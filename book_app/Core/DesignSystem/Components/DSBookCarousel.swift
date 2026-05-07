//
//  DSBookCarousel.swift
//  book_app
//
//  Created by Gabriel Merenfeld on 10/04/26.
//

import SwiftUI

struct DSBookCarousel: View {
    let title: String
    let seeMoreAction: () -> Void
    let books: [BookInfo]
    
    var body: some View {
        VStack {
            titleAndSeeMoreButtonRow
            booksCarousel
        }
    }
    
    var titleAndSeeMoreButtonRow: some View {
        HStack {
            Text(title)
                .textStyle(.titleSmall)
            
            Spacer()
        }
        .padding(.horizontal, 16)
    }
    
    var booksCarousel: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0 ..< books.count) { index in
                    books[index]
                        .padding(.horizontal, 8)
                }
            }
        }
        .contentMargins(.horizontal, 4, for: .scrollContent)
    }
}

#Preview {
    DSBookCarousel(
        title: "lidos",
        seeMoreAction: {},
        books: BookModel.homeCarouselSamples.map { BookInfo(book: $0) }
    )
    .environment(AppCoordinator.previewLoggedIn())
}
