//
//  AddBooksSheetViewModel.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 23/04/26.
//

import Foundation
import Observation

@MainActor
@Observable
final class AddBooksSheetViewModel {
    var searchText: String = ""
    var isLoading: Bool = false
    var errorMessage: String?
    private(set) var filteredBooks: [BookModel] = []
    private var hasLoadedInitialBooks: Bool = false
    private let apiService: GoogleBooksAPIService?
    private let defaultSubject: String = "fiction"

    init(apiService: GoogleBooksAPIService? = try? GoogleBooksAPIService.live()) {
        self.apiService = apiService
    }

    func loadInitialBooksIfNeeded() async {
        guard !hasLoadedInitialBooks else { return }
        hasLoadedInitialBooks = true
        await loadBooks(title: "", genre: defaultSubject, author: "")
    }

    func handleSearchTextChanged() async {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        if query.isEmpty {
            guard hasLoadedInitialBooks else { return }
            await loadBooks(title: "", genre: defaultSubject, author: "")
            return
        }

        do {
            try await Task.sleep(for: .milliseconds(350))
        } catch {
            return
        }

        guard !Task.isCancelled else { return }
        await loadBooks(title: query, genre: "", author: query)
    }

    private func loadBooks(title: String, genre: String, author: String) async {
        guard let apiService else {
            errorMessage = "Não foi possível iniciar a busca de livros."
            filteredBooks = []
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            filteredBooks = try await apiService.findAll(title: title, genre: genre, author: author)
        } catch let error as NetworkError {
            filteredBooks = []
            errorMessage = message(for: error)
        } catch {
            filteredBooks = []
            errorMessage = "Não foi possível carregar os livros."
        }

        isLoading = false
    }

    private func message(for error: NetworkError) -> String {
        switch error {
        case .missingConfiguration:
            return "Chave da API não configurada."
        case .invalidQuery:
            return "Informe um termo para buscar livros."
        default:
            return "Não foi possível carregar os livros."
        }
    }
}
