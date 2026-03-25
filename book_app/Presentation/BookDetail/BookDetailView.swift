//
//  BookDetailView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 23/03/26.
//

import SwiftUI

struct BookDetailView: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Image("book")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 328)
                    .frame(maxWidth: .infinity)
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.orange)
                        .font(.caption)
                    Text("4.5")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                BookDetailInfo()
                Divider()
                    .padding(.vertical)
                Text("Comentários")
                    .fontWeight(.semibold)
                ForEach(1..<5) { _ in
                    BookDetailComments()
                }
            }
        }
        .padding(.top)
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Image(systemName: "bookmark")
                        .font(.title3)
                        .padding(.trailing, 15)
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
