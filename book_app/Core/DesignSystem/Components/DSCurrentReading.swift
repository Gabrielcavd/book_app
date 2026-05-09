//
//  CurrentReading.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 07/03/26.
//

import SwiftUI

struct DSCurrentReading: View {
    let book: BookModel?

    var body: some View {
        Group {
            if let book {
                HStack {
                    BookCoverImage(url: book.coverImageURL)
                        .frame(width: 100, height: 120)
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(book.title)
                                .textStyle(.titleSmall)
                                .lineLimit(2)

                            Text(book.primaryAuthorDisplay)
                                .textStyle(.body)
                        }
                        progressBookColumn(pageCount: book.pageCount)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 24)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color(.systemBackground))
                )
                .defaultShadow()
            } else {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Nenhum livro em leitura")
                        .textStyle(.titleSmall)
                    Text("Adicione um livro e escolha “Começar a ler” para acompanhar aqui.")
                        .textStyle(.caption)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.vertical, 24)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color(.systemBackground))
                )
                .defaultShadow()
            }
        }
    }

    private func progressBookColumn(pageCount: Int?) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            ProgressView(value: 0.35)
                .tint(.black)

            HStack {
                if let pageCount, pageCount > 0 {
                    Text("Meta: \(pageCount) páginas")
                        .textStyle(.caption)
                } else {
                    Text("Progresso em breve")
                        .textStyle(.caption)
                }

                Spacer()

                Text("—")
                    .textStyle(.caption)
            }
        }
    }
}

#Preview {
    DSCurrentReading(book: nil)
}
