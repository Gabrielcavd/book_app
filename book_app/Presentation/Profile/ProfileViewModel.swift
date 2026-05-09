//
//  ProfileViewModel.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 17/04/26.
//

import Foundation
import Observation
import SwiftData

struct ProfileReview: Identifiable, Equatable {
    let id: String
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
    var fullName = ""
    var email = ""
    var profileImageName: String?
    var profileImageData: Data?

    var favoriteAuthor = ""
    var pagesRead = ""
    var favoriteGenre = ""
    var favoriteQuote = ""
    var reviews: [ProfileReview] = []

    var isShowingEditProfile = false

    private(set) var booksReadDisplay = "0"
    private(set) var booksReadingDisplay = "0"
    private(set) var wishlistDisplay = "0"

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

    func refresh(modelContext: ModelContext, userId: UUID?) {
        guard let userId,
              let user = UserRepository(context: modelContext).fetchUser(byId: userId)
        else {
            fullName = ""
            email = ""
            profileImageName = nil
            profileImageData = nil
            favoriteAuthor = ""
            pagesRead = ""
            favoriteGenre = ""
            favoriteQuote = ""
            reviews = []
            booksReadDisplay = "0"
            booksReadingDisplay = "0"
            wishlistDisplay = "0"
            return
        }

        fullName = user.fullName
        email = user.email
        profileImageData = user.avatarData
        profileImageName = user.avatarData == nil ? "avatar" : nil
        favoriteAuthor = user.favoriteAuthor
        pagesRead = user.pagesRead
        favoriteGenre = user.favoriteGenre
        favoriteQuote = user.favoriteQuote

        let repo = SavedBookRepository(context: modelContext)
        booksReadDisplay = String(repo.countRead(for: userId))
        booksReadingDisplay = String(repo.countReading(for: userId))
        wishlistDisplay = String(repo.countWishlist(for: userId))

        reviews = repo.reviews(for: userId).map { entity in
            ProfileReview(
                id: entity.googleBookId,
                title: entity.title,
                content: entity.opinion,
                rating: entity.userRating
            )
        }
    }

    func updateProfile(modelContext: ModelContext, userId: UUID?, with data: EditableProfileData) {
        guard let userId else { return }
        do {
            try UserRepository(context: modelContext).updateProfile(
                userId: userId,
                fullName: data.fullName,
                email: data.email,
                favoriteAuthor: data.favoriteAuthor,
                pagesRead: data.pagesRead,
                favoriteGenre: data.favoriteGenre,
                favoriteQuote: data.favoriteQuote,
                avatarData: data.profileImageData
            )
            refresh(modelContext: modelContext, userId: userId)
        } catch {
        }
    }
}
