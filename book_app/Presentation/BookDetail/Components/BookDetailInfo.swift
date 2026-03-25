//
//  BookDetailInfo.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 25/03/26.
//

import SwiftUI

struct BookDetailInfo: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Senhor do Anéis")
                .font(.system(size: 24))
                .fontWeight(.semibold)
                .padding(.vertical, 5)
            Text("J.R.R Tolkien")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.bottom, 15)
            Text("O Senhor dos Anéis é um livro de alta fantasia, escrito pelo escritor britânico J. R. R. Tolkien. Escrita entre 1937 e 1949, com muitas partes criadas durante a Segunda Guerra Mundial, a saga é uma continuação de O Hobbit.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.bottom, 6)
            Text("2530 leitores • 326 páginas")
                .font(.caption)
                .padding(.bottom, 6)
        }
    }
}

#Preview {
    BookDetailInfo()
}
