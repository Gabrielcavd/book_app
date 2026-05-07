//
//  LibraryViewModel.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 23/04/26.
//

import Foundation
import Observation

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

    private let allBooks: [LibraryBookItem] = [
        LibraryBookItem(book: .sampleSenhorDosAneis, isRead: true, isFavorite: true),
        LibraryBookItem(book: .sampleDomCasmurro, isRead: true, isFavorite: false),
        LibraryBookItem(book: .sampleRevolucaoBichos, isRead: false, isFavorite: true),
        LibraryBookItem(book: .samplePequenoPrincipe, isRead: true, isFavorite: true),
        LibraryBookItem(book: .sample1984, isRead: false, isFavorite: false),
        LibraryBookItem(book: .sampleHarryPotter, isRead: false, isFavorite: false),
        LibraryBookItem(book: .samplePacienteSilenciosa, isRead: true, isFavorite: false),
        LibraryBookItem(book: .sampleMemoriasBrasCubas, isRead: false, isFavorite: false),
    ]

    var filteredBooks: [LibraryBookItem] {
        let booksForTab = books(for: selectedTab)
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return booksForTab }

        return booksForTab.filter { item in
            item.book.title.localizedCaseInsensitiveContains(query)
                || item.book.primaryAuthorDisplay.localizedCaseInsensitiveContains(query)
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
