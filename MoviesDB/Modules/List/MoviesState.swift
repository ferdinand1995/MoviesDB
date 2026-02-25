//
//  MoviesState.swift
//  MoviesDB
//
//  Created by Ferdinand Tedjakusuma on 21/02/26.
//

import Foundation

struct Movie: Identifiable, Hashable {
    private(set) var id: UUID = .init()
    var title: String
    var posterURL: String
}

struct MovieRecentSearch: Identifiable, Hashable, Codable {
    private(set) var id: UUID = .init()
    var item: String
}

struct MovieSearch: Hashable {
    var movieList: [Movie]
    var recentSearch: [MovieRecentSearch]

    init(
        movieList: [Movie] = [],
        recentSearch: [MovieRecentSearch] = []
    ) {
        self.movieList = movieList
        self.recentSearch = recentSearch
    }
}

struct MoviesState: Equatable, Sendable {
    var movies: [Movie] = []
    var listItem = MovieSearch()
    var isLoading: Bool = false
    var errorMessage: String? = nil

    var textInput: String = ""
    var progress: CGFloat = 0
    var isFocused: Bool = false
}
