//
//  LoginViewModel.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 12/04/26.
//

import Foundation
import Observation
import SwiftData

@Observable
final class LoginViewModel {
    var email = ""
    var password = ""

    private(set) var emailError: String?
    private(set) var passwordError: String?
    private(set) var formError: String?

    func clearEmailError() {
        emailError = nil
    }

    func clearPasswordError() {
        passwordError = nil
    }

    func clearFormError() {
        formError = nil
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

    func logIn(using coordinator: AppCoordinator, modelContext: ModelContext) {
        formError = nil
        guard validateForm() else { return }
        do {
            let user = try AuthService(context: modelContext).logIn(email: email, password: password)
            coordinator.logIn(userId: user.id)
        } catch {
            formError = "Email ou senha incorretos."
        }
    }
}
