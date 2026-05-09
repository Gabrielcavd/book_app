//
//  AuthService.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 09/05/26.
//

import Foundation
import SwiftData

@MainActor
struct AuthService {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func register(
        email: String,
        fullName: String,
        password: String,
        avatarData: Data?
    ) throws -> UserEntity {
        let user = try UserRepository(context: context).createUser(
            email: email,
            fullName: fullName,
            password: password,
            avatarData: avatarData
        )
        try SessionRepository(context: context).setActiveUser(id: user.id)
        return user
    }

    func logIn(email: String, password: String) throws -> UserEntity {
        let user = try UserRepository(context: context).verifyLogin(email: email, password: password)
        try SessionRepository(context: context).setActiveUser(id: user.id)
        return user
    }

    func logOut() throws {
        try SessionRepository(context: context).clearSession()
    }

    func resetPassword(email: String, newPassword: String) throws {
        try UserRepository(context: context).updatePassword(email: email, newPassword: newPassword)
    }
}
