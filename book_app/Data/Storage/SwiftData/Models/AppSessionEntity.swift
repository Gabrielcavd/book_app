//
//  AppSessionEntity.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 09/05/26.
//

import Foundation
import SwiftData

@Model
final class AppSessionEntity {
    @Attribute(.unique) var singletonKey: String
    var activeUserId: UUID?
    var lastLoginAt: Date?

    init(singletonKey: String = "app", activeUserId: UUID? = nil, lastLoginAt: Date? = Date()) {
        self.singletonKey = singletonKey
        self.activeUserId = activeUserId
        self.lastLoginAt = lastLoginAt
    }
}
