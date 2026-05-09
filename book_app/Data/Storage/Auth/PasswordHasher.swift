//
//  PasswordHasher.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 09/05/26.
//

import CryptoKit
import Foundation

enum PasswordHasher {
    static func hash(_ password: String) -> String {
        let data = Data(password.utf8)
        let digest = SHA256.hash(data: data)
        return digest.map { String(format: "%02x", $0) }.joined()
    }

    static func verify(_ password: String, matchesHash storedHash: String) -> Bool {
        Self.hash(password) == storedHash
    }
}
