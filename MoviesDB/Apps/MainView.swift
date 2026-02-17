//
//  MoviesView.swift
//  MoviesDB
//
//  Created by Ferdinand Tedjakusuma on 17/02/26.
//

import SwiftUI

struct MainView: View {
    @StateObject private var router = ViewRouter()

    var body: some View {
        NavigationStack(path: $router.path) {
            // Root view
            buildView(for: .home)
                .navigationDestination(for: AppRoute.self) { route in
                    buildView(for: route)
                }
                .sheet(item: $router.presentedSheet) { route in
                    buildView(for: route)
                }
                .fullScreenCover(item: $router.presentedFullScreen) { route in
                    buildView(for: route)
                }
        }
        .environmentObject(router)
    }

    // MARK: - View Builder

    @ViewBuilder
    private func buildView(for route: AppRoute) -> some View {
        switch route {
        case .home:
            HomeView()
        case .profile(let userId):
            ProfileView(userId: userId)
        case .settings:
            SettingsView()
        case .detail(let id):
            DetailView(id: id)
        }
    }
}
