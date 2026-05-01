//
//  BookDetailView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 23/03/26.
//

import SwiftUI

struct BookDetailView: View {
    @State private var isBookSaved = false
    @State private var bookReview = BookReview()
    
    func saveBook() {
        isBookSaved = true
    }

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Image("book")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 328)
                    .frame(maxWidth: .infinity)
                
                BookDetailInfo(bookReview: $bookReview)
                
                Divider()
                    .padding(.vertical)
                
                Text("Comentários")
                    .fontWeight(.semibold)
                ForEach(1 ..< 5) { _ in
                    BookDetailComments()
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(.top)
        .padding(.horizontal, 16)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Menu {
                        Button("Lidos", action: saveBook)
                        Button("Favoritos", action: saveBook)
                        Button("Não lidos", action: saveBook)
                    } label: {
                        Image(systemName: isBookSaved ? "bookmark.fill" : "bookmark")
                            .font(.title3)
                            .padding(.trailing, 15)
                            .tint(.primary)
                    }

                    Image(systemName: "square.and.arrow.up")
                        .font(.title3)
                }
            }
        }
    }
}

#Preview {
    BookDetailView()
}
