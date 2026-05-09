//
//  UserEntity.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 09/05/26.
//

import Foundation
import SwiftData

@Model
final class UserEntity {
    @Attribute(.unique) var email: String
    var id: UUID
    var fullName: String
    var passwordHash: String
    var createdAt: Date
    var updatedAt: Date
    @Attribute(.externalStorage) var avatarData: Data?

    var favoriteAuthor: String
    var pagesRead: String
    var favoriteGenre: String
    var favoriteQuote: String

    @Relationship(deleteRule: .cascade, inverse: \SavedBookEntity.user)
    var savedBooks: [SavedBookEntity] = []

    init(
        id: UUID = UUID(),
        email: String,
        fullName: String,
        passwordHash: String,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        avatarData: Data? = nil,
        favoriteAuthor: String = "",
        pagesRead: String = "",
        favoriteGenre: String = "",
        favoriteQuote: String = ""
    ) {
        self.id = id
        self.email = email
        self.fullName = fullName
        self.passwordHash = passwordHash
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.avatarData = avatarData
        self.favoriteAuthor = favoriteAuthor
        self.pagesRead = pagesRead
        self.favoriteGenre = favoriteGenre
        self.favoriteQuote = favoriteQuote
    }
}
