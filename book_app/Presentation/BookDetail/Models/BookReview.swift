//
//  BookReview.swift
//  book_app
//
//  Created by Gabriel Merenfeld on 28/04/26.
//

import Foundation

struct BookReview: Equatable {
    var bookId: String
    var rating: Int = 0
    var opinion: String = ""
    var readingStatus: ReadingStatus = .notRead
    var createdAt: Date = Date()
}
