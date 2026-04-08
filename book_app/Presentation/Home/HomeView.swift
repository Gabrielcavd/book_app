//
//  HomeView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 06/03/26.
//

import SwiftUI

struct HomeView: View {
    let books = [
        BookInfo(),
        BookInfo(),
        BookInfo(),
        BookInfo(),
    ]
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 40) {
                HomeViewHeader(userName: "Gabriel Cavalcante")
                
                CurrentReading(seeMoreAction: {})
                
                DSBookCarousel(
                    title: "Lidos",
                    seeMoreAction: {},
                    books: books
                )
                
                DSBookCarousel(
                    title: "Ler depois",
                    seeMoreAction: {},
                    books: books
                )
                
                DSBookCarousel(
                    title: "Não gostei",
                    seeMoreAction: {},
                    books: books
                )
            }
        }
        .padding(.vertical)
        .padding(.horizontal, 24)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .environment(AppCoordinator.previewLoggedIn())
}
