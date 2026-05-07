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
