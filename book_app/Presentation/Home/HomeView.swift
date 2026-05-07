//
//  HomeView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 06/03/26.
//

import SwiftUI

struct HomeView: View {
    private var carouselBookInfos: [BookInfo] {
        BookModel.homeCarouselSamples.map { BookInfo(book: $0) }
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 24) {
                HomeViewHeader(userName: "Gabriel Cavalcante")
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                
                CurrentReading(seeMoreAction: {})
                    .padding(.horizontal, 16)
                
                DSBookCarousel(
                    title: "Lidos",
                    seeMoreAction: {},
                    books: carouselBookInfos
                )
                
                DSBookCarousel(
                    title: "Ler depois",
                    seeMoreAction: {},
                    books: carouselBookInfos
                )
                
                DSBookCarousel(
                    title: "Não gostei",
                    seeMoreAction: {},
                    books: carouselBookInfos
                )
                .padding(.bottom, 16)
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .environment(AppCoordinator.previewLoggedIn())
}
