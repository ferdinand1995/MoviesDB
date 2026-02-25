//
//  MoviesAction.swift
//  MoviesDB
//
//  Created by Ferdinand Tedjakusuma on 25/02/26.
//

import Foundation

enum MoviesAction: Sendable {
    case onAppear
    case fetchMovies
    case onSearchInputChange(String)
    case onFocusSearchBar(Bool)
    case onScrollProgress(CGFloat)
    case clearRecentSearch
//    case moviesLoaded([Movie])
//    case moviesFailed(String)

}
