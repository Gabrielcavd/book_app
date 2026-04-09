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
                    .padding(.top, 8)
                
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
        .padding(.horizontal, 16)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .environment(AppCoordinator.previewLoggedIn())
}
