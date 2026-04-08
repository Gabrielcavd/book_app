//
//  DSBookCarousel.swift
//  book_app
//
//  Created by Gabriel Merenfeld on 08/04/26.
//

import SwiftUI

struct DSBookCarousel: View {
    let title: String
    let seeMoreAction: () -> Void
    let books: [BookInfo]
    
    var body: some View {
        VStack {
            titleAndSeeMoreButtonRow
            booksScrollHorizontal
        }
        .environment(AppCoordinator())
    }
    
    var titleAndSeeMoreButtonRow: some View {
        HStack {
            Text(title)
                .textStyle(.titleMedium)
            
            Spacer()
            
            Button("Ver mais", action: seeMoreAction)
                .foregroundColor(.blue)
                .textStyle(.titleSmall)
        }
    }
    
    var booksScrollHorizontal: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0 ..< books.count, id: \.self) { index in
                    books[index]
                        .padding(.horizontal, 5)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    DSBookCarousel(
        title: "Destaques",
        seeMoreAction: {},
        books: [
            BookInfo(),
            BookInfo(),
            BookInfo(),
            BookInfo(),
            BookInfo(),
            BookInfo(),
            BookInfo(),
        ]
    )
}
