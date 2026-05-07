//
//  RaitingBookDetail.swift
//  book_app
//
//  Created by Gabriel Merenfeld on 28/04/26.
//

import SwiftUI

struct RatingView: View {
    @State private var showModal: Bool = false
    @Binding var bookReview: BookReview
    
    private let titles: [Int: String] = [
        1: "Péssimo",
        2: "Ruim",
        3: "Bom",
        4: "Muito Bom",
        5: "Excelente"
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 8) {
                stars
                
                Text(bookReview.rating == 0 ? "sem avaliação" : "\(titles[bookReview.rating] ?? "")")
                    .font(.system(size: 18))
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .sheet(isPresented: $showModal) {
            RaintingModalBookDetail(
                bookId: bookReview.bookId,
                titles: titles,
                bookReview: $bookReview,
            )
            .presentationDetents([.height(460)])
            .presentationDragIndicator(.hidden)
        }
    }
    
    var stars: some View {
        ForEach(1...5, id: \.self) { index in
            Image(systemName: index <= bookReview.rating ? "star.fill" : "star")
                .font(.system(size: 28))
                .foregroundColor(index <= bookReview.rating ? .yellow : .gray)
                .onTapGesture {
                    bookReview.rating = index
                    showModal = true
                }
        }
    }
}
