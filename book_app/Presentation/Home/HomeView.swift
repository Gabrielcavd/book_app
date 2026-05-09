//
//  HomeView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 06/03/26.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @Environment(AppCoordinator.self) private var coordinator
    @Environment(\.modelContext) private var modelContext

    @State private var viewModel = HomeViewModel()

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 24) {
                HomeViewHeader(userName: viewModel.userFirstName.isEmpty ? "Leitor" : viewModel.userFirstName)
                    .padding(.top, 16)
                    .padding(.horizontal, 16)

                CurrentReading(book: viewModel.currentReadingBook, seeMoreAction: {})
                    .padding(.horizontal, 16)

                shelfCarousel(
                    title: "Lidos",
                    books: viewModel.readBooks,
                    emptyMessage: "Você ainda não marcou nenhum livro como lido."
                )

                shelfCarousel(
                    title: "Ler depois",
                    books: viewModel.readLaterBooks,
                    emptyMessage: "Nada na lista de leitura. Adicione livros pela biblioteca."
                )

                shelfCarousel(
                    title: "Não gostei",
                    books: viewModel.dislikedBooks,
                    emptyMessage: "Nenhum livro marcado aqui."
                )
                .padding(.bottom, 16)
            }
        }
        .scrollIndicators(.hidden)
        .onAppear {
            viewModel.refresh(modelContext: modelContext, userId: coordinator.currentUserId)
        }
        .onChange(of: coordinator.currentUserId) { _, _ in
            viewModel.refresh(modelContext: modelContext, userId: coordinator.currentUserId)
        }
        .onReceive(NotificationCenter.default.publisher(for: .savedBooksDidChange)) { _ in
            viewModel.refresh(modelContext: modelContext, userId: coordinator.currentUserId)
        }
    }

    @ViewBuilder
    private func shelfCarousel(title: String, books: [BookModel], emptyMessage: String) -> some View {
        if books.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .textStyle(.titleSmall)
                    .padding(.horizontal, 16)
                Text(emptyMessage)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 16)
            }
        } else {
            DSBookCarousel(
                title: title,
                seeMoreAction: {},
                books: books.map { BookInfo(book: $0) }
            )
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .appModelContainer(AppModelContainer.previewInMemory)
    .environment(AppCoordinator.previewLoggedIn())
}
