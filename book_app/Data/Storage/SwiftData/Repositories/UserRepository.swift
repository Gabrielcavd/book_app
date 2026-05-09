//
//  UserRepository.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 09/05/26.
//

import Foundation
import SwiftData

enum UserRepositoryError: LocalizedError {
    case emailAlreadyRegistered
    case userNotFound
    case emailAlreadyInUse

    var errorDescription: String? {
        switch self {
        case .emailAlreadyRegistered:
            return "Este email já está cadastrado."
        case .userNotFound:
            return "Usuário não encontrado."
        case .emailAlreadyInUse:
            return "Este email já está em uso por outra conta."
        }
    }
}

@MainActor
struct UserRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetchUser(byId id: UUID) -> UserEntity? {
        let predicate = #Predicate<UserEntity> { $0.id == id }
        var descriptor = FetchDescriptor<UserEntity>(predicate: predicate)
        descriptor.fetchLimit = 1
        return try? context.fetch(descriptor).first
    }

    func fetchUser(byEmail email: String) -> UserEntity? {
        let normalized = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let predicate = #Predicate<UserEntity> { $0.email == normalized }
        var descriptor = FetchDescriptor<UserEntity>(predicate: predicate)
        descriptor.fetchLimit = 1
        return try? context.fetch(descriptor).first
    }

    func createUser(
        email: String,
        fullName: String,
        password: String,
        avatarData: Data?
    ) throws -> UserEntity {
        let normalized = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if fetchUser(byEmail: normalized) != nil {
            throw UserRepositoryError.emailAlreadyRegistered
        }
        let entity = UserEntity(
            email: normalized,
            fullName: fullName.trimmingCharacters(in: .whitespacesAndNewlines),
            passwordHash: PasswordHasher.hash(password),
            avatarData: avatarData
        )
        context.insert(entity)
        try context.save()
        return entity
    }

    func verifyLogin(email: String, password: String) throws -> UserEntity {
        let normalized = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard let user = fetchUser(byEmail: normalized) else {
            throw UserRepositoryError.userNotFound
        }
        guard PasswordHasher.verify(password, matchesHash: user.passwordHash) else {
            throw UserRepositoryError.userNotFound
        }
        return user
    }

    func updatePassword(email: String, newPassword: String) throws {
        let normalized = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard let user = fetchUser(byEmail: normalized) else {
            throw UserRepositoryError.userNotFound
        }
        user.passwordHash = PasswordHasher.hash(newPassword)
        user.updatedAt = Date()
        try context.save()
    }

    func updateProfile(
        userId: UUID,
        fullName: String,
        email: String,
        favoriteAuthor: String,
        pagesRead: String,
        favoriteGenre: String,
        favoriteQuote: String,
        avatarData: Data?
    ) throws {
        guard let user = fetchUser(byId: userId) else {
            throw UserRepositoryError.userNotFound
        }
        let normalizedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if normalizedEmail != user.email {
            if let other = fetchUser(byEmail: normalizedEmail), other.id != user.id {
                throw UserRepositoryError.emailAlreadyInUse
            }
        }
        user.fullName = fullName.trimmingCharacters(in: .whitespacesAndNewlines)
        user.email = normalizedEmail
        user.favoriteAuthor = favoriteAuthor
        user.pagesRead = pagesRead
        user.favoriteGenre = favoriteGenre
        user.favoriteQuote = favoriteQuote
        user.avatarData = avatarData
        user.updatedAt = Date()
        try context.save()
    }
}
