//
//  BookInfo.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 07/03/26.
//

import SwiftUI

struct BookInfo: View {
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                Image("book")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 103, height: 143)
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.orange)
                        .font(.caption)
                    Text("4.5")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                .padding(4)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.background)
                )
                .padding(5)
            }
            Text("Senhor dos Anéis")
                .fontWeight(.semibold)
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true)
            Text("J.R.R Tolkien")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(width: 110)
    }
}

#Preview {
    BookInfo()
}
