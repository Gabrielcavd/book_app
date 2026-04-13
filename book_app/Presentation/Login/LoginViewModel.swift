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
        let trimmed = email.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty {
            emailError = "Informe seu email."
            return false
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        guard predicate.evaluate(with: trimmed) else {
            emailError = "Email inválido."
            return false
        }
        emailError = nil
        return true
    }

    @discardableResult
    func validatePassword() -> Bool {
        if password.isEmpty {
            passwordError = "Informe sua senha."
            return false
        }
        if password.count < 6 {
            passwordError = "A senha deve ter pelo menos 6 caracteres."
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
