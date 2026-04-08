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
                HomeViewHeader()
                CurrentReading()
                    .padding(.horizontal)
                FeaturedBooksSectionHome()
                FeaturedClubsSection()
            }
        }
        .padding(.top)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .environment(AppCoordinator.previewLoggedIn())
}
