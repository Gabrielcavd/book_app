//
//  AppModelContainer.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 09/05/26.
//

import SwiftData
import SwiftUI

enum AppModelContainer {
    private static let schema = Schema([UserEntity.self, AppSessionEntity.self, SavedBookEntity.self])

    static var live: ModelContainer {
        guard let container = try? ModelContainer(for: schema, configurations: [ModelConfiguration()]) else {
            fatalError("Could not create SwiftData ModelContainer")
        }
        return container
    }

    static var previewInMemory: ModelContainer {
        guard
            let container = try? ModelContainer(
                for: schema,
                configurations: [ModelConfiguration(isStoredInMemoryOnly: true)]
            )
        else {
            fatalError("Could not create in-memory SwiftData ModelContainer")
        }
        return container
    }
}

extension View {
    func appModelContainer(_ container: ModelContainer) -> some View {
        modelContainer(container)
    }
}
