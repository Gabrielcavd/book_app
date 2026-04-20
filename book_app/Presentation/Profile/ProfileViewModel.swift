//
//  ProfileViewModel.swift
//  book_app
//
//  Created by Codex on 17/04/26.
//

import Foundation
import Observation

struct ProfileReview: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var content: String
    var rating: Int
}

struct EditableProfileData {
    var fullName: String
    var email: String
    var favoriteAuthor: String
    var pagesRead: String
    var favoriteGenre: String
    var favoriteQuote: String
    var profileImageData: Data?
}

@Observable
final class ProfileViewModel {
    var fullName = "Gabriel Dantas"
    var email = "gabriel@gmail.com"
    var profileImageName: String? = "avatar"
    var profileImageData: Data?

    var favoriteAuthor = ""
    var pagesRead = ""
    var favoriteGenre = ""
    var favoriteQuote = ""
    var reviews: [ProfileReview] = []

    var isShowingEditProfile = false

    var hasFavorites: Bool {
        !favoriteAuthor.isEmpty || !pagesRead.isEmpty || !favoriteGenre.isEmpty
    }

    var hasStats: Bool {
        hasFavorites || hasReviews
    }

    var hasQuote: Bool {
        !favoriteQuote.isEmpty
    }

    var hasReviews: Bool {
        !reviews.isEmpty
    }

    var booksReadDisplay: String {
        hasFavorites ? "24" : "0"
    }

    var booksReadingDisplay: String {
        hasFavorites ? "2" : "0"
    }

    var wishlistDisplay: String {
        hasFavorites ? "12" : "0"
    }

    var editableData: EditableProfileData {
        EditableProfileData(
            fullName: fullName,
            email: email,
            favoriteAuthor: favoriteAuthor,
            pagesRead: pagesRead,
            favoriteGenre: favoriteGenre,
            favoriteQuote: favoriteQuote,
            profileImageData: profileImageData
        )
    }

    func updateProfile(with data: EditableProfileData) {
        fullName = data.fullName
        email = data.email
        favoriteAuthor = data.favoriteAuthor
        pagesRead = data.pagesRead
        favoriteGenre = data.favoriteGenre
        favoriteQuote = data.favoriteQuote
        profileImageData = data.profileImageData
        if data.profileImageData != nil {
            profileImageName = nil
        }
    }
}
