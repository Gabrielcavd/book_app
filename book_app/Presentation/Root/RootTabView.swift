//
//  RootTabView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 06/03/26.
//

import SwiftUI

struct RootTabView: View {
    @Environment(AppCoordinator.self) private var coordinator

    var body: some View {
        @Bindable var coordinator = coordinator
        TabView(selection: $coordinator.selectedTab) {
            NavigationStack(path: $coordinator.homePath) {
                HomeView()
                    .navigationDestination(for: BookRoute.self) { route in
                        switch route {
                        case .detail:
                            BookDetailView()
                        }
                    }
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(TabItem.home)

            BookClubView()
                .tabItem {
                    Label("Clube", systemImage: "person.3.fill")
                }
                .tag(TabItem.club)

            NavigationStack(path: $coordinator.libraryPath) {
                LibraryView()
                    .navigationDestination(for: BookRoute.self) { route in
                        switch route {
                        case .detail:
                            BookDetailView()
                        }
                    }
            }
            .tabItem {
                Label("Biblioteca", systemImage: "books.vertical.fill")
            }
            .tag(TabItem.library)

            ProfileView()
                .tabItem {
                    Label("Perfil", systemImage: "person.crop.circle.fill")
                }
                .tag(TabItem.profile)
        }
    }
}

#Preview {
    RootTabView()
        .environment(AppCoordinator.previewLoggedIn())
}
