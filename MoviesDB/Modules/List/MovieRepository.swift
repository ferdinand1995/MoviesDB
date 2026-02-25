//
//  MovieRepository.swift
//  MoviesDB
//
//  Created by Ferdinand Tedjakusuma on 25/02/26.
//

import Foundation

protocol MoviesRepository: Sendable {
    var recentSearch: [MovieRecentSearch] { get }
    func updateRecentSearch(_ item: String) async
    func clearRecentSearch() async
}

actor MovieRepositoryImplementation: @preconcurrency MoviesRepository {
    
    @UserDefault(key: UserDefaultsKey.recent, defaultValue: [])
    private(set) var recentSearch: [MovieRecentSearch]
    
    func updateRecentSearch(_ item: String) async {
        let newItem = MovieRecentSearch(item: item)
        recentSearch.append(newItem)
    }
    
    func clearRecentSearch() async {
        recentSearch.removeAll()
    }
    
    
}
