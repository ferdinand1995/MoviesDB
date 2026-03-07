//
//  MoviesReducer.swift
//  MoviesDB
//
//  Created by Ferdinand Tedjakusuma on 25/02/26.
//

import Foundation

struct MoviesReducer: FeatureReducer {
    private let repository: MoviesRepository

    init(repository: MoviesRepository = MovieRepositoryImplementation()) {
        self.repository = repository
    }

    func callAsFunction(
        state: MoviesState,
        action: MoviesAction
    ) -> [Effect<MoviesState, MoviesAction>] {
        switch action {
        case .clearRecentSearch:
            var next = state
            next.listItem.recentSearch = []
            return [.newState(next), .run({ send in
                await repository.clearRecentSearch()
            })]
        case .onSearchInputChange(let newValue):
            var next = state
            next.textInput = newValue
            return [.newState(next), .run({ [newValue] send in
                guard !newValue.isEmpty else { return }
                try? await Task.sleep(for: .milliseconds(300))
                await repository.updateRecentSearch(newValue)
            })]
        case .onFocusSearchBar(let newValue):
            var next = state
            next.isFocused = newValue
            return [.newState(next), .run({ send in
                let result = await repository.fetchRecentSearch()
                await send(.fetchRecentSearch(result))
            })]
        case .onScrollProgress(let newValue):
            var next = state
            next.progress = newValue
            return [.newState(next)]
        case .fetchMovies:
            return []
        case .fetchRecentSearch(let newValue):
            var next = state
            next.listItem.recentSearch = newValue
            return [.newState(next)]
        case .onAppear:
            return [.run({ send in
                let result = await repository.fetchRecentSearch()
                await send(.fetchRecentSearch(result))
            })]
        }
    }
}
