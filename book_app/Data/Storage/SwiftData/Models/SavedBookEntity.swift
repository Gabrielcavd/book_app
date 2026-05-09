//
//  SavedBookEntity.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 09/05/26.
//

import Foundation
import SwiftData

@Model
final class SavedBookEntity {
    var id: UUID
    var ownerUserId: UUID
    var googleBookId: String
    var title: String
    var authorsSerialized: String
    var thumbnailURL: String
    var publishedDate: String?
    var pageCount: Int?
    var bookDescription: String?
    var categoriesSerialized: String
    var averageRating: Double?
    var readingStatusRaw: String
    var isFavorite: Bool
    var isDisliked: Bool
    var userRating: Int
    var opinion: String
    var savedAt: Date
    var updatedAt: Date

    var user: UserEntity?

    init(
        id: UUID = UUID(),
        ownerUserId: UUID,
        googleBookId: String,
        title: String,
        authorsSerialized: String,
        thumbnailURL: String,
        publishedDate: String?,
        pageCount: Int?,
        bookDescription: String?,
        categoriesSerialized: String,
        averageRating: Double?,
        readingStatusRaw: String,
        isFavorite: Bool,
        isDisliked: Bool,
        userRating: Int = 0,
        opinion: String = "",
        savedAt: Date = Date(),
        updatedAt: Date = Date(),
        user: UserEntity? = nil
    ) {
        self.id = id
        self.ownerUserId = ownerUserId
        self.googleBookId = googleBookId
        self.title = title
        self.authorsSerialized = authorsSerialized
        self.thumbnailURL = thumbnailURL
        self.publishedDate = publishedDate
        self.pageCount = pageCount
        self.bookDescription = bookDescription
        self.categoriesSerialized = categoriesSerialized
        self.averageRating = averageRating
        self.readingStatusRaw = readingStatusRaw
        self.isFavorite = isFavorite
        self.isDisliked = isDisliked
        self.userRating = userRating
        self.opinion = opinion
        self.savedAt = savedAt
        self.updatedAt = updatedAt
        self.user = user
    }
}
