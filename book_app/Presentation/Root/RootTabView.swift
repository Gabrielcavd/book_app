//
//  RootTabView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 06/03/26.
//

import SwiftUI

enum TabItem: Int {
    case home
    case club
    case library
    case profile
}

struct RootTabView: View {
    @State private var selection: TabItem = .home

    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(TabItem.home)

            Text("Clube")
                .tabItem {
                    Label("Clube", systemImage: "person.3.fill")
                }
                .tag(TabItem.club)

            Text("Biblioteca")
                .tabItem {
                    Label("Biblioteca", systemImage: "books.vertical.fill")
                }
                .tag(TabItem.library)

            Text("Perfil")
                .tabItem {
                    Label("Perfil", systemImage: "person.crop.circle.fill")
                }
                .tag(TabItem.profile)
        }
    }
}

#Preview {
    RootTabView()
}
