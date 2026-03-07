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
                HStack(alignment: .center) {
                    Image("avatar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text("Oi Gabriel!")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("O que você vai ler hoje?")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.horizontal)
                CurrentReading()
                FeaturedBooksSectionHome()
                FeaturedClubsSection()
            }
        }
        .padding(.top)
        
    }
}

#Preview {
    HomeView()
}
