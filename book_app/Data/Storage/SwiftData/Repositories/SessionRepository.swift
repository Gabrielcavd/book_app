//
//  SessionRepository.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 09/05/26.
//

import Foundation
import SwiftData

@MainActor
struct SessionRepository {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    private func sessionRow() throws -> AppSessionEntity {
        let descriptor = FetchDescriptor<AppSessionEntity>()
        if let existing = try context.fetch(descriptor).first {
            return existing
        }
        let row = AppSessionEntity()
        context.insert(row)
        try context.save()
        return row
    }

    func activeUserId() throws -> UUID? {
        try sessionRow().activeUserId
    }

    func setActiveUser(id: UUID?) throws {
        let row = try sessionRow()
        row.activeUserId = id
        row.lastLoginAt = Date()
        try context.save()
    }

    func clearSession() throws {
        try setActiveUser(id: nil)
    }
}
