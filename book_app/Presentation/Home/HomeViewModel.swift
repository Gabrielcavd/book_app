//
//  HomeViewModel.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 09/05/26.
//

import Foundation
import Observation
import SwiftData

@Observable
final class HomeViewModel {
    var userFirstName: String = ""

    private(set) var readBooks: [BookModel] = []
    private(set) var readLaterBooks: [BookModel] = []
    private(set) var dislikedBooks: [BookModel] = []
    private(set) var currentReadingBook: BookModel?

    func refresh(modelContext: ModelContext, userId: UUID?) {
        guard let userId else {
            userFirstName = ""
            readBooks = []
            readLaterBooks = []
            dislikedBooks = []
            currentReadingBook = nil
            return
        }
        if let user = UserRepository(context: modelContext).fetchUser(byId: userId) {
            let parts = user.fullName.split(separator: " ")
            userFirstName = parts.first.map(String.init) ?? user.fullName
        } else {
            userFirstName = ""
        }

        let repository = SavedBookRepository(context: modelContext)
        readBooks = repository.booksRead(for: userId).map(SavedBookMapper.bookModel(from:))
        readLaterBooks = repository.booksReadLater(for: userId).map(SavedBookMapper.bookModel(from:))
        dislikedBooks = repository.booksDisliked(for: userId).map(SavedBookMapper.bookModel(from:))
        if let entity = repository.currentReadingCandidate(for: userId) {
            currentReadingBook = SavedBookMapper.bookModel(from: entity)
        } else {
            currentReadingBook = nil
        }
    }
}
