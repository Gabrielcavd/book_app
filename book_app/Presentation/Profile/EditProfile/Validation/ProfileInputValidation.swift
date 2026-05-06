//
//  ProfileInputValidation.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 17/04/26.
//

import Foundation

enum ProfileInputValidation {
    static func fullNameValidationMessage(for rawName: String) -> String? {
        let trimmed = rawName.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.isEmpty { return "Informe seu nome completo." }
        return nil
    }

    static func emailValidationMessage(for rawEmail: String) -> String? {
        AuthInputValidation.emailValidationMessage(for: rawEmail)
    }

    static func pagesReadValidationMessage(for rawPagesRead: String) -> String? {
        let trimmed = rawPagesRead.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }
        guard Int(trimmed) != nil else { return "Informe apenas numeros para paginas lidas." }
        return nil
    }
}
