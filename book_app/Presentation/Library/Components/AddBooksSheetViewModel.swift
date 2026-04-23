//
//  AddBooksSheetViewModel.swift
//  book_app
//
//  Created by Codex on 23/04/26.
//

import Foundation
import Observation

struct AddBookItem: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let author: String
}

@Observable
final class AddBooksSheetViewModel {
    var searchText: String = ""

    private let allBooks: [AddBookItem] = [
        AddBookItem(title: "Senhor dos Aneis", author: "J.R.R. Tolkien"),
        AddBookItem(title: "Dom Casmurro", author: "Machado de Assis"),
        AddBookItem(title: "A Revolucao dos Bichos", author: "George Orwell"),
        AddBookItem(title: "O Pequeno Principe", author: "Antoine de Saint-Exupery"),
        AddBookItem(title: "1984", author: "George Orwell"),
        AddBookItem(title: "Harry Potter e a Pedra Filosofal", author: "J.K. Rowling"),
        AddBookItem(title: "A Paciente Silenciosa", author: "Alex Michaelides"),
        AddBookItem(title: "Memorias Postumas de Bras Cubas", author: "Machado de Assis"),
    ]

    var filteredBooks: [AddBookItem] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return allBooks }

        return allBooks.filter { book in
            book.title.localizedCaseInsensitiveContains(query) ||
                book.author.localizedCaseInsensitiveContains(query)
        }
    }
}
