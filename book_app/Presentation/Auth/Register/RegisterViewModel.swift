//
//  RegisterViewModel.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 12/04/26.
//

import Foundation
import Observation

@Observable
final class RegisterViewModel {
    var email = ""
    var fullName = ""
    var password = ""
    var confirmPassword = ""

    private(set) var emailError: String?
    private(set) var fullNameError: String?
    private(set) var passwordError: String?
    private(set) var confirmPasswordError: String?

    func clearEmailError() { emailError = nil }
    func clearFullNameError() { fullNameError = nil }
    func clearPasswordError() { passwordError = nil }
    func clearConfirmPasswordError() { confirmPasswordError = nil }

    @discardableResult
    func validateEmail() -> Bool {
        if let message = AuthInputValidation.emailValidationMessage(for: email) {
            emailError = message
            return false
        }
        emailError = nil
        return true
    }

    @discardableResult
    func validateFullName() -> Bool {
        if let message = AuthInputValidation.fullNameValidationMessage(for: fullName) {
            fullNameError = message
            return false
        }
        fullNameError = nil
        return true
    }

    @discardableResult
    func validatePassword() -> Bool {
        if let message = AuthInputValidation.passwordValidationMessage(for: password) {
            passwordError = message
            return false
        }
        passwordError = nil
        return true
    }

    @discardableResult
    func validateConfirmPassword() -> Bool {
        if let message = AuthInputValidation.confirmPasswordValidationMessage(
            password: password,
            confirmation: confirmPassword
        ) {
            confirmPasswordError = message
            return false
        }
        confirmPasswordError = nil
        return true
    }

    func validateForm() -> Bool {
        let emailOK = validateEmail()
        let nameOK = validateFullName()
        let passwordOK = validatePassword()
        let confirmOK = validateConfirmPassword()
        return emailOK && nameOK && passwordOK && confirmOK
    }

    func register() {
        guard validateForm() else { return }
        // TODO: call registration API when available
    }
}
