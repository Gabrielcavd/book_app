//
//  AddBooksSheetView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 23/04/26.
//

import SwiftUI

struct AddBooksSheetView: View {
    @State private var viewModel = AddBooksSheetViewModel()
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 100), alignment: .top),
    ]

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 16) {
                Text("Adicionar livros")
                    .font(.headline)

                TextField("Pesquise por autor ou titulo", text: $viewModel.searchText)
                    .safeAreaInset(edge: .leading) { Image(systemName: "magnifyingglass") }
                    .padding(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(.secondary.opacity(0.5), lineWidth: 1)
                    )

                if viewModel.isLoading && viewModel.filteredBooks.isEmpty {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 24)
                } else if let errorMessage = viewModel.errorMessage, viewModel.filteredBooks.isEmpty {
                    Text(errorMessage)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 24)
                } else if viewModel.filteredBooks.isEmpty {
                    Text("Nenhum livro encontrado")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 24)
                } else {
                    LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                        ForEach(viewModel.filteredBooks) { book in
                            AddBooksSheetBookCard(
                                navigationStack: .library,
                                book: book
                            )
                        }
                    }
                }
            }
            .padding()
        }
        .presentationDetents([.medium, .large])
        .task {
            await viewModel.loadInitialBooksIfNeeded()
        }
        .task(id: viewModel.searchText) {
            await viewModel.handleSearchTextChanged()
        }
    }
}

#Preview {
    AddBooksSheetView()
        .environment(AppCoordinator.previewLoggedIn())
}
