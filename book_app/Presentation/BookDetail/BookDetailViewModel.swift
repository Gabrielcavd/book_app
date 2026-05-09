//
//  BookDetailViewModel.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 09/05/26.
//

import Foundation
import Observation
import SwiftData

@Observable
final class BookDetailViewModel {
    let book: BookModel

    var bookReview: BookReview
    var isSavedToLibrary = false

    private var isHydratingState = false

    init(book: BookModel) {
        self.book = book
        self.bookReview = BookReview(bookId: book.id)
    }

    func onAppear(modelContext: ModelContext, userId: UUID?) {
        loadPersistedState(modelContext: modelContext, userId: userId)
    }

    func onReviewChanged(modelContext: ModelContext, userId: UUID?) {
        guard !isHydratingState else { return }
        persistReviewState(bookReview, modelContext: modelContext, userId: userId)
    }

    func markAsRead(modelContext: ModelContext, userId: UUID?) {
        guard let userId else { return }
        do {
            try SavedBookRepository(context: modelContext).markAsRead(book: book, userId: userId)
            isSavedToLibrary = true
            bookReview.readingStatus = .alreadyRead
            postSavedBooksDidChange()
        } catch {}
    }

    func markAsFavorite(modelContext: ModelContext, userId: UUID?) {
        guard let userId else { return }
        do {
            try SavedBookRepository(context: modelContext).markAsFavorite(book: book, userId: userId)
            isSavedToLibrary = true
            postSavedBooksDidChange()
        } catch {}
    }

    func markAsNotRead(modelContext: ModelContext, userId: UUID?) {
        guard let userId else { return }
        do {
            try SavedBookRepository(context: modelContext).markAsNotRead(book: book, userId: userId)
            isSavedToLibrary = true
            bookReview.readingStatus = .notRead
            postSavedBooksDidChange()
        } catch {}
    }

    func markAsDisliked(modelContext: ModelContext, userId: UUID?) {
        guard let userId else { return }
        do {
            try SavedBookRepository(context: modelContext).markAsDisliked(book: book, userId: userId)
            isSavedToLibrary = true
            bookReview.readingStatus = .notRead
            postSavedBooksDidChange()
        } catch {}
    }

    private func loadPersistedState(modelContext: ModelContext, userId: UUID?) {
        guard let userId else { return }
        let repository = SavedBookRepository(context: modelContext)
        guard let entity = repository.entity(googleBookId: book.id, userId: userId) else {
            isSavedToLibrary = false
            return
        }

        isSavedToLibrary = true
        let status = SavedBookMapper.readingStatus(from: entity)

        isHydratingState = true
        bookReview = BookReview(
            bookId: book.id,
            rating: entity.userRating,
            opinion: entity.opinion,
            readingStatus: status,
            createdAt: entity.updatedAt
        )
        isHydratingState = false
    }

    private func persistReviewState(_ review: BookReview, modelContext: ModelContext, userId: UUID?) {
        guard let userId else { return }
        let repository = SavedBookRepository(context: modelContext)

        do {
            if repository.entity(googleBookId: book.id, userId: userId) == nil {
                try repository.upsert(
                    book: book,
                    userId: userId,
                    readingStatus: review.readingStatus,
                    isFavorite: false,
                    isDisliked: false
                )
                isSavedToLibrary = true
            } else {
                try repository.updateReadingStatus(
                    googleBookId: book.id,
                    userId: userId,
                    status: review.readingStatus
                )
            }

            try repository.updateReview(
                googleBookId: book.id,
                userId: userId,
                rating: review.rating,
                opinion: review.opinion
            )
            postSavedBooksDidChange()
        } catch {}
    }

    private func postSavedBooksDidChange() {
        NotificationCenter.default.post(name: .savedBooksDidChange, object: nil)
    }
}
