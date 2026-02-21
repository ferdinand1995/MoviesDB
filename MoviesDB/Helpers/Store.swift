//
//  Store.swift
//  MoviesDB
//
//  Created by Ferdinand Tedjakusuma on 20/02/26.
//
//  # Unidirectional Data Flow Store
//
//  A lightweight implementation of the unidirectional data flow (UDF) pattern
//  for SwiftUI, inspired by The Elm Architecture (TEA) and Redux.
//
//  ## Core Concepts
//
//  ```
//  User Interaction
//       │
//       ▼
//    intent(action)
//       │
//       ▼
//  FeatureReducer          ← pure function, no side effects
//       │
//       ├── Effect.newState(State)   → updates published state
//       └── Effect.run(async work)  → async side effects, may dispatch new actions
//       │
//       ▼
//    MVIObject.state        ← @Observable, SwiftUI reacts automatically
//       │
//       ▼
//     View re-renders
//  ```
//
//  ## Components
//
//  - `Send` — a typealias for the async callback that async effects use to
//    dispatch follow-up actions back into the store.
//
//  - `Effect` — the return type of a reducer. Either a direct state update
//    (`.newState`) or async work (`.run`). A single action can return multiple
//    effects, e.g. an optimistic state update followed by a network call.
//
//  - `FeatureReducer` — a `Sendable` protocol for pure reducer logic. Implement
//    `callAsFunction(state:action:)` to map (State, Action) → [Effect]. Because
//    it conforms to `Sendable` and has no stored mutable state, it is safe to
//    use across concurrency boundaries.
//
//  - `MVIObject` — the `@MainActor` `@Observable` store that owns state and
//    drives the cycle. Views hold a `@State` reference to it and call
//    `intent(_:)` to dispatch actions.
//
//  ## References
//
//  - The Elm Architecture: https://guide.elm-lang.org/architecture
//  - Redux: https://redux.js.org/understanding/thinking-in-redux/three-principles
//  - Point-Free TCA: https://github.com/pointfreeco/swift-composable-architecture
//  - Swift Observation (@Observable): https://developer.apple.com/documentation/observation
//
//  ## Example
//
//  ```swift
//  // 1. Define State and Action
//  struct MoviesState: Equatable, Sendable {
//      var movies: [Movie] = []
//      var isLoading: Bool = false
//      var errorMessage: String? = nil
//  }
//
//  enum MoviesAction: Sendable {
//      case fetchMovies
//      case moviesLoaded([Movie])
//      case moviesFailed(String)
//  }
//
//  // 2. Implement FeatureReducer
//  struct MoviesReducer: FeatureReducer {
//      func callAsFunction(
//          state: MoviesState,
//          action: MoviesAction
//      ) -> [Effect<MoviesState, MoviesAction>] {
//          switch action {
//          case .fetchMovies:
//              var loading = state
//              loading.isLoading = true
//              return [
//                  .newState(loading),
//                  .run { send in
//                      do {
//                          let movies = try await MovieService.fetchAll()
//                          await send(.moviesLoaded(movies))
//                      } catch {
//                          await send(.moviesFailed(error.localizedDescription))
//                      }
//                  }
//              ]
//
//          case .moviesLoaded(let movies):
//              var next = state
//              next.movies = movies
//              next.isLoading = false
//              return [.newState(next)]
//
//          case .moviesFailed(let message):
//              var next = state
//              next.isLoading = false
//              next.errorMessage = message
//              return [.newState(next)]
//          }
//      }
//  }
//
//  // 3. Bind to View
//  struct MoviesView: View {
//      @State private var store = MVIObject(
//          initialState: MoviesState(),
//          reducer: MoviesReducer()
//      )
//
//      var body: some View {
//          Group {
//              if store.state.isLoading {
//                  ProgressView()
//              } else if let error = store.state.errorMessage {
//                  Text(error).foregroundStyle(.red)
//              } else {
//                  List(store.state.movies) { movie in
//                      Text(movie.title)
//                  }
//              }
//          }
//          .onAppear {
//              store.intent(.fetchMovies)
//          }
//      }
//  }
//  ```
//

import Foundation
import SwiftUI

// MARK: - Send

typealias Send<Action: Sendable> = @Sendable (Action) async -> Void

// MARK: - Effect

enum Effect<State: Equatable & Sendable, Action: Sendable> {
    case newState(State)
    case run((@escaping Send<Action>) async -> Void)
}

// MARK: - Reducer Protocol

protocol FeatureReducer<State, Action>: Sendable {
    associatedtype State: Equatable & Sendable
    associatedtype Action: Sendable
    func callAsFunction(state: State, action: Action) -> [Effect<State, Action>]
}

// MARK: - MVIObject

@Observable
@MainActor
final class MVIObject<R: FeatureReducer> {
    private(set) var state: R.State

    private let reducer: R

    init(initialState: R.State, reducer: R) {
        self.state = initialState
        self.reducer = reducer
    }

    func intent(_ action: R.Action) {
        let effects = reducer(state: state, action: action)
        for effect in effects {
            switch effect {
            case .newState(let newState):
                if newState != state { state = newState }
            case .run(let work):
                Task { [weak self] in
                    await work { [weak self] action in
                        await self?.intent(action)
                    }
                }
            }
        }
    }
}
