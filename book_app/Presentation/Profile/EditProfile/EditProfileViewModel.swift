//
//  EditProfileViewModel.swift
//  book_app
//
//  Created by Codex on 17/04/26.
//

import Foundation
import Observation

@Observable
final class EditProfileViewModel {
    var fullName: String
    var email: String
    var favoriteAuthor: String
    var pagesRead: String
    var favoriteGenre: String
    var favoriteQuote: String
    var profileImageData: Data?

    private(set) var fullNameError: String?
    private(set) var emailError: String?
    private(set) var pagesReadError: String?

    init(data: EditableProfileData) {
        fullName = data.fullName
        email = data.email
        favoriteAuthor = data.favoriteAuthor
        pagesRead = data.pagesRead
        favoriteGenre = data.favoriteGenre
        favoriteQuote = data.favoriteQuote
        profileImageData = data.profileImageData
    }

    func clearFullNameError() { fullNameError = nil }
    func clearEmailError() { emailError = nil }
    func clearPagesReadError() { pagesReadError = nil }

    @discardableResult
    func validateFullName() -> Bool {
        if let message = ProfileInputValidation.fullNameValidationMessage(for: fullName) {
            fullNameError = message
            return false
        }
        fullNameError = nil
        return true
    }

    @discardableResult
    func validateEmail() -> Bool {
        if let message = ProfileInputValidation.emailValidationMessage(for: email) {
            emailError = message
            return false
        }
        emailError = nil
        return true
    }

    @discardableResult
    func validatePagesRead() -> Bool {
        if let message = ProfileInputValidation.pagesReadValidationMessage(for: pagesRead) {
            pagesReadError = message
            return false
        }
        pagesReadError = nil
        return true
    }

    func validateForm() -> Bool {
        let nameOK = validateFullName()
        let emailOK = validateEmail()
        let pagesOK = validatePagesRead()
        return nameOK && emailOK && pagesOK
    }

    func makeProfileData() -> EditableProfileData? {
        guard validateForm() else { return nil }
        return EditableProfileData(
            fullName: fullName,
            email: email,
            favoriteAuthor: favoriteAuthor.trimmingCharacters(in: .whitespacesAndNewlines),
            pagesRead: pagesRead.trimmingCharacters(in: .whitespacesAndNewlines),
            favoriteGenre: favoriteGenre.trimmingCharacters(in: .whitespacesAndNewlines),
            favoriteQuote: favoriteQuote.trimmingCharacters(in: .whitespacesAndNewlines),
            profileImageData: profileImageData
        )
    }
}
