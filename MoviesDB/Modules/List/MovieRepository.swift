//
//  MovieRepository.swift
//  MoviesDB
//
//  Created by Ferdinand Tedjakusuma on 25/02/26.
//

import Foundation

protocol MoviesRepository: Sendable {
    func fetchRecentSearch() async -> [MovieRecentSearch]
    func updateRecentSearch(_ item: String) async
    func clearRecentSearch() async
}

actor MovieRepositoryImplementation: @preconcurrency MoviesRepository {
    @UserDefault(key: UserDefaultsKey.recent, defaultValue: [])
    private var recentSearch: [MovieRecentSearch]

    private var searchTask: Task<Void, Never>?

    func fetchRecentSearch() async -> [MovieRecentSearch] {
        recentSearch
    }

    func updateRecentSearch(_ item: String) async {
        searchTask?.cancel()
        searchTask = Task {
            try? await Task.sleep(for: .milliseconds(300))
            guard !Task.isCancelled else { return }
            let newItem = MovieRecentSearch(item: item)
            recentSearch.append(newItem)
        }
    }

    func clearRecentSearch() async {
        recentSearch.removeAll()
    }
}
