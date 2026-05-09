//
//  SavedBookRepository.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 09/05/26.
//

import Foundation
import SwiftData

@MainActor
struct SavedBookRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func entity(googleBookId: String, userId: UUID) -> SavedBookEntity? {
        let predicate = #Predicate<SavedBookEntity> { entity in
            entity.googleBookId == googleBookId && entity.ownerUserId == userId
        }
        var descriptor = FetchDescriptor<SavedBookEntity>(predicate: predicate)
        descriptor.fetchLimit = 1
        return try? context.fetch(descriptor).first
    }

    func allSaved(for userId: UUID) -> [SavedBookEntity] {
        let predicate = #Predicate<SavedBookEntity> { $0.ownerUserId == userId }
        let descriptor = FetchDescriptor<SavedBookEntity>(
            predicate: predicate,
            sortBy: [SortDescriptor(\.updatedAt, order: .reverse)]
        )
        return (try? context.fetch(descriptor)) ?? []
    }

    func countRead(for userId: UUID) -> Int {
        allSaved(for: userId).filter { SavedBookMapper.readingStatus(from: $0) == .alreadyRead && !$0.isDisliked }.count
    }

    func countReading(for userId: UUID) -> Int {
        allSaved(for: userId).filter { SavedBookMapper.readingStatus(from: $0) == .startReading }.count
    }

    func countWishlist(for userId: UUID) -> Int {
        allSaved(for: userId).filter { SavedBookMapper.readingStatus(from: $0) == .readLater }.count
    }

    func reviews(for userId: UUID) -> [SavedBookEntity] {
        allSaved(for: userId).filter { !$0.opinion.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    }

    func currentReadingCandidate(for userId: UUID) -> SavedBookEntity? {
        allSaved(for: userId).first { SavedBookMapper.readingStatus(from: $0) == .startReading }
    }

    func booksRead(for userId: UUID) -> [SavedBookEntity] {
        allSaved(for: userId).filter { SavedBookMapper.readingStatus(from: $0) == .alreadyRead && !$0.isDisliked }
    }

    func booksReadLater(for userId: UUID) -> [SavedBookEntity] {
        allSaved(for: userId).filter { SavedBookMapper.readingStatus(from: $0) == .readLater }
    }

    func booksDisliked(for userId: UUID) -> [SavedBookEntity] {
        allSaved(for: userId).filter(\.isDisliked)
    }

    func upsert(
        book: BookModel,
        userId: UUID,
        readingStatus: ReadingStatus,
        isFavorite: Bool,
        isDisliked: Bool
    ) throws {
        guard let user = UserRepository(context: context).fetchUser(byId: userId) else { return }
        if let existing = entity(googleBookId: book.id, userId: userId) {
            SavedBookMapper.applySnapshot(from: book, to: existing)
            existing.ownerUserId = userId
            existing.readingStatusRaw = readingStatus.rawValue
            existing.isFavorite = isFavorite
            existing.isDisliked = isDisliked
            existing.updatedAt = Date()
        } else {
            let newEntity = SavedBookMapper.newEntity(
                from: book,
                user: user,
                readingStatus: readingStatus,
                isFavorite: isFavorite,
                isDisliked: isDisliked
            )
            context.insert(newEntity)
        }
        try context.save()
    }

    func updateReadingStatus(googleBookId: String, userId: UUID, status: ReadingStatus) throws {
        guard let existing = entity(googleBookId: googleBookId, userId: userId) else { return }
        existing.readingStatusRaw = status.rawValue
        if status == .alreadyRead {
            existing.isDisliked = false
        }
        existing.updatedAt = Date()
        try context.save()
    }

    func updateFavorite(googleBookId: String, userId: UUID, isFavorite: Bool) throws {
        guard let existing = entity(googleBookId: googleBookId, userId: userId) else { return }
        existing.isFavorite = isFavorite
        existing.updatedAt = Date()
        try context.save()
    }

    func updateReview(googleBookId: String, userId: UUID, rating: Int, opinion: String) throws {
        guard let existing = entity(googleBookId: googleBookId, userId: userId) else { return }
        existing.userRating = rating
        existing.opinion = opinion
        existing.updatedAt = Date()
        try context.save()
    }

    func markAsRead(book: BookModel, userId: UUID) throws {
        try upsert(book: book, userId: userId, readingStatus: .alreadyRead, isFavorite: false, isDisliked: false)
    }

    func markAsFavorite(book: BookModel, userId: UUID) throws {
        if let existing = entity(googleBookId: book.id, userId: userId) {
            existing.isFavorite = true
            SavedBookMapper.applySnapshot(from: book, to: existing)
            existing.updatedAt = Date()
            try context.save()
        } else {
            try upsert(book: book, userId: userId, readingStatus: .notRead, isFavorite: true, isDisliked: false)
        }
    }

    func markAsNotRead(book: BookModel, userId: UUID) throws {
        try upsert(book: book, userId: userId, readingStatus: .notRead, isFavorite: false, isDisliked: false)
    }

    func markAsDisliked(book: BookModel, userId: UUID) throws {
        try upsert(book: book, userId: userId, readingStatus: .notRead, isFavorite: false, isDisliked: true)
    }
}
