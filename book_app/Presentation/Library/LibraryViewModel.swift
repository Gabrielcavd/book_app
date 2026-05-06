//
//  LibraryViewModel.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 23/04/26.
//

import Foundation
import Observation

struct LibraryBookItem: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let author: String
    let isRead: Bool
    let isFavorite: Bool
}

@Observable
final class LibraryViewModel {
    var searchText: String = ""
    var selectedTab: LibraryTab = .todos

    private let allBooks: [LibraryBookItem] = [
        LibraryBookItem(title: "Senhor dos Aneis", author: "J.R.R. Tolkien", isRead: true, isFavorite: true),
        LibraryBookItem(title: "Dom Casmurro", author: "Machado de Assis", isRead: true, isFavorite: false),
        LibraryBookItem(title: "A Revolucao dos Bichos", author: "George Orwell", isRead: false, isFavorite: true),
        LibraryBookItem(title: "O Pequeno Principe", author: "Antoine de Saint-Exupery", isRead: true, isFavorite: true),
        LibraryBookItem(title: "1984", author: "George Orwell", isRead: false, isFavorite: false),
        LibraryBookItem(title: "Harry Potter e a Pedra Filosofal", author: "J.K. Rowling", isRead: false, isFavorite: false),
        LibraryBookItem(title: "A Paciente Silenciosa", author: "Alex Michaelides", isRead: true, isFavorite: false),
        LibraryBookItem(title: "Memorias Postumas de Bras Cubas", author: "Machado de Assis", isRead: false, isFavorite: false),
    ]

    var filteredBooks: [LibraryBookItem] {
        let booksForTab = books(for: selectedTab)
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return booksForTab }

        return booksForTab.filter { book in
            book.title.localizedCaseInsensitiveContains(query) ||
                book.author.localizedCaseInsensitiveContains(query)
        }
    }

    var emptyStateMessage: String {
        if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Nenhum livro encontrado"
        }

        switch selectedTab {
        case .todos:
            return "Nada por aqui"
        case .lidos:
            return "Nenhum livro lido"
        case .favoritos:
            return "Nenhum favorito"
        case .naolidos:
            return "Nenhum livro nao lido"
        }
    }

    private func books(for tab: LibraryTab) -> [LibraryBookItem] {
        switch tab {
        case .todos:
            return allBooks
        case .lidos:
            return allBooks.filter(\.isRead)
        case .favoritos:
            return allBooks.filter(\.isFavorite)
        case .naolidos:
            return allBooks.filter { !$0.isRead }
        }
    }
}
