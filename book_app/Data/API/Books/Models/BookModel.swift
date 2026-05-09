//
//  BookModel.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 04/05/26.
//

import Foundation

struct BookModel: Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let authors: [String]
    let publishedDate: String?
    let description: String?
    let pageCount: Int?
    let categories: [String]
    let language: String?
    let smallThumbnail: String
    let averageRating: Double?
}

extension BookModel {
    static let previewStub = BookModel(
        id: "preview-stub",
        title: "Livro de exemplo",
        authors: ["Autor Exemplo"],
        publishedDate: "2020-01-01",
        description: "Descrição de exemplo para preview.",
        pageCount: 200,
        categories: ["Ficção"],
        language: "pt",
        smallThumbnail: "",
        averageRating: 4.5
    )
}
