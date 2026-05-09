//
//  LibraryViewModel.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 23/04/26.
//

import Foundation
import Observation
import SwiftData

struct LibraryBookItem: Identifiable, Equatable {
    let book: BookModel
    let isRead: Bool
    let isFavorite: Bool

    var id: String { book.id }
}

@Observable
final class LibraryViewModel {
    var searchText: String = ""
    var selectedTab: LibraryTab = .todos

    private(set) var items: [LibraryBookItem] = []

    func refresh(modelContext: ModelContext, userId: UUID?) {
        guard let userId else {
            items = []
            return
        }
        let repository = SavedBookRepository(context: modelContext)
        let allBooks = repository.allSaved(for: userId)
        let booksForTab = filterEntities(allBooks, tab: selectedTab)
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        let filtered: [SavedBookEntity]
        if query.isEmpty {
            filtered = booksForTab
        } else {
            filtered = booksForTab.filter { entity in
                entity.title.localizedCaseInsensitiveContains(query)
                    || SavedBookMapper.deserializeAuthors(entity.authorsSerialized)
                    .joined(separator: " ")
                    .localizedCaseInsensitiveContains(query)
            }
        }
        items = filtered.map { entity in
            let status = SavedBookMapper.readingStatus(from: entity)
            let isRead = status == .alreadyRead && !entity.isDisliked
            return LibraryBookItem(
                book: SavedBookMapper.bookModel(from: entity),
                isRead: isRead,
                isFavorite: entity.isFavorite
            )
        }
    }

    var filteredBooks: [LibraryBookItem] { items }

    var emptyStateMessage: String {
        if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Nenhum livro encontrado"
        }

        switch selectedTab {
        case .todos:
            return "Sua biblioteca está vazia. Toque em + para adicionar livros."
        case .lidos:
            return "Nenhum livro lido ainda"
        case .favoritos:
            return "Nenhum favorito ainda"
        case .naolidos:
            return "Nenhum livro não lido"
        }
    }

    private func filterEntities(_ entities: [SavedBookEntity], tab: LibraryTab) -> [SavedBookEntity] {
        switch tab {
        case .todos:
            return entities
        case .lidos:
            return entities.filter { SavedBookMapper.readingStatus(from: $0) == .alreadyRead && !$0.isDisliked }
        case .favoritos:
            return entities.filter(\.isFavorite)
        case .naolidos:
            return entities.filter {
                !(SavedBookMapper.readingStatus(from: $0) == .alreadyRead && !$0.isDisliked)
            }
        }
    }
}
