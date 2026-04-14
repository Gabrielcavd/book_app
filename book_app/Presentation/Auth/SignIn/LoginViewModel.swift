//
//  LoginViewModel.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 12/04/26.
//

import Foundation
import Observation

@Observable
final class LoginViewModel {
    var email = ""
    var password = ""

    private(set) var emailError: String?
    private(set) var passwordError: String?

    func clearEmailError() {
        emailError = nil
    }

    func clearPasswordError() {
        passwordError = nil
    }

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
    func validatePassword() -> Bool {
        if let message = AuthInputValidation.passwordValidationMessage(for: password) {
            passwordError = message
            return false
        }
        passwordError = nil
        return true
    }

    func validateForm() -> Bool {
        let emailOK = validateEmail()
        let passwordOK = validatePassword()
        return emailOK && passwordOK
    }

    func logIn(using coordinator: AppCoordinator) {
        guard validateForm() else { return }
        coordinator.logIn()
    }
}
