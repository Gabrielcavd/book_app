//
//  ForgotPasswordViewModel.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 12/04/26.
//

import Foundation
import Observation
import SwiftData

@Observable
final class ForgotPasswordViewModel {
    var email = ""
    var newPassword = ""
    var confirmPassword = ""

    private(set) var emailError: String?
    private(set) var newPasswordError: String?
    private(set) var confirmPasswordError: String?
    private(set) var formError: String?
    private(set) var successMessage: String?

    func clearEmailError() {
        emailError = nil
    }

    func clearNewPasswordError() {
        newPasswordError = nil
    }

    func clearConfirmPasswordError() {
        confirmPasswordError = nil
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
    func validateNewPassword() -> Bool {
        if let message = AuthInputValidation.passwordValidationMessage(for: newPassword) {
            newPasswordError = message
            return false
        }
        newPasswordError = nil
        return true
    }

    @discardableResult
    func validateConfirmPassword() -> Bool {
        if let message = AuthInputValidation.confirmPasswordValidationMessage(
            password: newPassword,
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
        let passOK = validateNewPassword()
        let confirmOK = validateConfirmPassword()
        return emailOK && passOK && confirmOK
    }

    @discardableResult
    func submitResetRequest(modelContext: ModelContext) -> Bool {
        successMessage = nil
        formError = nil
        guard validateForm() else { return false }
        do {
            try AuthService(context: modelContext).resetPassword(
                email: email,
                newPassword: newPassword
            )
            successMessage = "Senha atualizada. Faça login com a nova senha."
            return true
        } catch UserRepositoryError.userNotFound {
            formError = "Não encontramos uma conta com este email."
            return false
        } catch {
            formError = "Não foi possível atualizar a senha."
            return false
        }
    }
}
