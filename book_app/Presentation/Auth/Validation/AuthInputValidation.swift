//
//  AuthInputValidation.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 12/04/26.
//

import Foundation

enum AuthInputValidation {
    private static let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    static func emailValidationMessage(for rawEmail: String) -> String? {
        let trimmed = rawEmail.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty { return "Informe seu email." }
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        guard predicate.evaluate(with: trimmed) else { return "Email inválido." }
        return nil
    }

    static func passwordValidationMessage(for password: String) -> String? {
        if password.isEmpty { return "Informe sua senha." }
        if password.count < 6 { return "A senha deve ter pelo menos 6 caracteres." }
        return nil
    }

    static func fullNameValidationMessage(for rawName: String) -> String? {
        let trimmed = rawName.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty { return "Informe seu nome completo." }
        return nil
    }

    static func confirmPasswordValidationMessage(password: String, confirmation: String) -> String? {
        if confirmation.isEmpty { return "Confirme sua senha." }
        if password != confirmation { return "As senhas não coincidem." }
        return nil
    }
}
