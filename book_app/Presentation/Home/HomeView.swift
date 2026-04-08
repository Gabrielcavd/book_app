//
//  HomeView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 06/03/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 24) {
                HomeViewHeader(userName: "Gabriel Cavalcante")
                CurrentReading()
                FeaturedBooksSectionHome()
                FeaturedClubsSection()
            }
        }
        .padding(.top)
        .padding(.horizontal, 24)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .environment(AppCoordinator.previewLoggedIn())
}
