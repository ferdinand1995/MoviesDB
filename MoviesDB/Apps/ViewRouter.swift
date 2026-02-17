//
//  ViewRouter.swift
//  MoviesDB
//
//

import SwiftUI

// MARK: - Route Definition

enum AppRoute: Hashable, Identifiable {
    case home
    case profile(userId: String)
    case settings
    case detail(id: Int)
    // Add your routes here
    
    var id: String {
        switch self {
        case .home:
            return "home"
        case .profile(let userId):
            return "profile-\(userId)"
        case .settings:
            return "settings"
        case .detail(let id):
            return "detail-\(id)"
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

// MARK: - Example Views

struct HomeView: View {
    @EnvironmentObject var router: ViewRouter
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Home View")
                .font(.largeTitle)
            
            Button("Push to Profile") {
                router.push(.profile(userId: "123"))
            }
            
            Button("Push to Settings") {
                router.push(.settings)
            }
            
            Button("Present Detail as Sheet") {
                router.present(.detail(id: 1))
            }
            
            Button("Present Full Screen") {
                router.presentFullScreen(.detail(id: 2))
            }
        }
        .navigationTitle("Home")
    }
}

struct ProfileView: View {
    @EnvironmentObject var router: ViewRouter
    let userId: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Profile View")
                .font(.largeTitle)
            Text("User ID: \(userId)")
            
            Button("Push to Settings") {
                router.push(.settings)
            }
            
            Button("Pop") {
                router.pop()
            }
            
            Button("Pop to Root") {
                router.popToRoot()
            }
        }
        .navigationTitle("Profile")
    }
}

struct SettingsView: View {
    @EnvironmentObject var router: ViewRouter
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Settings View")
                .font(.largeTitle)
            
            Button("Push to Detail") {
                router.push(.detail(id: 99))
            }
            
            Button("Pop") {
                router.pop()
            }
            
            Button("Pop to Root") {
                router.popToRoot()
            }
        }
        .navigationTitle("Settings")
    }
}

struct DetailView: View {
    @EnvironmentObject var router: ViewRouter
    let id: Int
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Detail View")
                .font(.largeTitle)
            Text("ID: \(id)")
            
            Button("Dismiss (if presented)") {
                router.dismiss()
            }
            
            Button("Pop (if pushed)") {
                router.pop()
            }
            
            Button("Pop to Root") {
                router.popToRoot()
            }
        }
        .navigationTitle("Detail")
    }
}
