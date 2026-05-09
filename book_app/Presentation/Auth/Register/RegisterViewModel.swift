//
//  RegisterViewModel.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 12/04/26.
//

import Foundation
import Observation
import SwiftData

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
    private(set) var formError: String?

    func clearEmailError() { emailError = nil }
    func clearFullNameError() { fullNameError = nil }
    func clearPasswordError() { passwordError = nil }
    func clearConfirmPasswordError() { confirmPasswordError = nil }
    func clearFormError() { formError = nil }

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

    @discardableResult
    func register(
        modelContext: ModelContext,
        coordinator: AppCoordinator,
        avatarData: Data?
    ) -> Bool {
        formError = nil
        guard validateForm() else { return false }
        do {
            let user = try AuthService(context: modelContext).register(
                email: email,
                fullName: fullName,
                password: password,
                avatarData: avatarData
            )
            coordinator.logIn(userId: user.id)
            return true
        } catch UserRepositoryError.emailAlreadyRegistered {
            emailError = UserRepositoryError.emailAlreadyRegistered.localizedDescription
            return false
        } catch {
            formError = "Não foi possível criar a conta."
            return false
        }
    }
}
