//
//  LibraryView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 15/03/26.
//

import SwiftUI

struct LibraryView: View {
    @State private var viewModel = LibraryViewModel()
    @State private var showSheet: Bool = false
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 100), alignment: .top),
    ]

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center, spacing: 24) {
                LibraryViewHeader {
                    showSheet.toggle()
                }
                TextField("Pesquise por autor ou título", text: $viewModel.searchText)
                    .safeAreaInset(edge: .leading) { Image(systemName: "magnifyingglass") }
                    .padding(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(.secondary.opacity(0.5), lineWidth: 1)
                    )
                Picker("", selection: $viewModel.selectedTab) {
                    Text("Todos").tag(LibraryTab.todos)
                    Text("Lidos").tag(LibraryTab.lidos)
                    Text("Favoritos").tag(LibraryTab.favoritos)
                    Text("Não lidos").tag(LibraryTab.naolidos)
                }
                .pickerStyle(.segmented)
                if viewModel.filteredBooks.isEmpty {
                    Text(viewModel.emptyStateMessage)
                        .foregroundStyle(.secondary)
                        .padding(.top, 12)
                } else {
                    LazyVGrid(columns: adaptiveColumn, alignment: .center, spacing: 20) {
                        ForEach(viewModel.filteredBooks) { book in
                            BookInfo(
                                navigationStack: .library,
                                title: book.title,
                                author: book.author
                            )
                        }
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                AddBooksSheetView()
            }
        }
        .padding(.top)
        .padding(.horizontal)
    }
}

enum LibraryTab {
    case todos
    case lidos
    case favoritos
    case naolidos
}

#Preview {
    NavigationStack {
        LibraryView()
    }
    .environment(AppCoordinator.previewLoggedIn())
}
