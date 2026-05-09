//
//  SavedBookMapper.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 09/05/26.
//

import Foundation

enum SavedBookMapper {
    static let authorsSeparator = "|||"

    static func serializeAuthors(_ authors: [String]) -> String {
        authors
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
            .joined(separator: authorsSeparator)
    }

    static func deserializeAuthors(_ serialized: String) -> [String] {
        serialized
            .components(separatedBy: authorsSeparator)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }

    static func serializeCategories(_ categories: [String]) -> String {
        categories
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
            .joined(separator: ", ")
    }

    static func deserializeCategories(_ serialized: String) -> [String] {
        serialized
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
            .map { String($0) }
    }

    static func bookModel(from entity: SavedBookEntity) -> BookModel {
        BookModel(
            id: entity.googleBookId,
            title: entity.title,
            authors: deserializeAuthors(entity.authorsSerialized),
            publishedDate: entity.publishedDate,
            description: entity.bookDescription,
            pageCount: entity.pageCount,
            categories: deserializeCategories(entity.categoriesSerialized),
            language: nil,
            smallThumbnail: entity.thumbnailURL,
            averageRating: entity.averageRating
        )
    }

    static func readingStatus(from entity: SavedBookEntity) -> ReadingStatus {
        ReadingStatus(rawValue: entity.readingStatusRaw) ?? .notRead
    }

    static func applySnapshot(from book: BookModel, to entity: SavedBookEntity) {
        entity.title = book.title
        entity.authorsSerialized = serializeAuthors(book.authors)
        entity.thumbnailURL = book.smallThumbnail
        entity.publishedDate = book.publishedDate
        entity.pageCount = book.pageCount
        entity.bookDescription = book.description
        entity.categoriesSerialized = serializeCategories(book.categories)
        entity.averageRating = book.averageRating
        entity.updatedAt = Date()
    }

    static func newEntity(
        from book: BookModel,
        user: UserEntity,
        readingStatus: ReadingStatus,
        isFavorite: Bool,
        isDisliked: Bool
    ) -> SavedBookEntity {
        let entity = SavedBookEntity(
            ownerUserId: user.id,
            googleBookId: book.id,
            title: book.title,
            authorsSerialized: serializeAuthors(book.authors),
            thumbnailURL: book.smallThumbnail,
            publishedDate: book.publishedDate,
            pageCount: book.pageCount,
            bookDescription: book.description,
            categoriesSerialized: serializeCategories(book.categories),
            averageRating: book.averageRating,
            readingStatusRaw: readingStatus.rawValue,
            isFavorite: isFavorite,
            isDisliked: isDisliked,
            user: user
        )
        return entity
    }
}
