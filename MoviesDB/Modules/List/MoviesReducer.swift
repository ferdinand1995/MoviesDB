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
            return [.newState(next), .run({ send in
                await repository.updateRecentSearch(newValue)
            })]
        case .onFocusSearchBar(let newValue):
            var next = state
            next.isFocused = newValue
            return [.newState(next)]
        case .onScrollProgress(let newValue):
            var next = state
            next.progress = newValue
            return [.newState(next)]
        case .fetchMovies:
            return []
        case .onAppear:
            var next = state
            next.listItem.recentSearch = repository.recentSearch
            return [.newState(next)]
        }
    }
}
