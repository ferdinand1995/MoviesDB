//
//  ViewRouter.swift
//  MoviesDB
//
//

import SwiftUI

// MARK: - Route Definition

enum AppRoute: Hashable, Identifiable {
    case search
    case detail(movieId: String)
   
    // Add your routes here
    
    var id: String {
        switch self {
        case .search:
            return "search"
        case .detail(let movieId):
            return "movie-detail-\(movieId)"
        }
    }
}

// MARK: - Router

@MainActor
class ViewRouter: ObservableObject {
    @Published var path: NavigationPath = .init()
    @Published var presentedSheet: AppRoute?
    @Published var presentedFullScreen: AppRoute?
    
    // MARK: - Navigation Methods
    
    /// Push a new view onto the stack
    func push(_ route: AppRoute) {
        path.append(route)
    }
    
    /// Present as sheet
    func present(_ route: AppRoute) {
        presentedSheet = route
    }
    
    /// Present as full screen cover
    func presentFullScreen(_ route: AppRoute) {
        presentedFullScreen = route
    }
    
    /// Pop the top view
    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
    
    /// Pop to root (clear entire stack)
    func popToRoot() {
        path = NavigationPath()
    }
    
    /// Dismiss sheet or full screen
    func dismiss() {
        presentedSheet = nil
        presentedFullScreen = nil
    }
    
    /// Pop to a specific number of views back
    func pop(count: Int) {
        let removeCount = min(count, path.count)
        path.removeLast(removeCount)
    }
}
