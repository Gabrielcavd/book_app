//
//  ForgotPasswordViewModel.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 12/04/26.
//

import Foundation
import Observation

@Observable
final class ForgotPasswordViewModel {
    var email = ""

    private(set) var emailError: String?

    func clearEmailError() {
        emailError = nil
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

    func submitResetRequest() {
        guard validateEmail() else { return }
        // TODO: call recovery API when available
    }
}
