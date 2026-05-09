//
//  BookDetailView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 23/03/26.
//

import SwiftUI
import SwiftData

struct BookDetailView: View {
    let book: BookModel

    @Environment(AppCoordinator.self) private var coordinator
    @Environment(\.modelContext) private var modelContext

    @State private var viewModel: BookDetailViewModel

    init(book: BookModel) {
        self.book = book
        _viewModel = State(initialValue: BookDetailViewModel(book: book))
    }

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                BookCoverImage(url: book.coverImageURL)
                    .frame(width: 220, height: 328)
                    .frame(maxWidth: .infinity)

                BookDetailInfo(
                    book: book,
                    bookReview: Binding(
                        get: { viewModel.bookReview },
                        set: { viewModel.bookReview = $0 }
                    )
                )

                Divider()
                    .padding(.vertical)

                Text("Comentários")
                    .fontWeight(.semibold)
                ForEach(1 ..< 5) { _ in
                    BookDetailComments()
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(.top)
        .padding(.horizontal, 16)
        .onAppear {
            viewModel.onAppear(modelContext: modelContext, userId: coordinator.currentUserId)
        }
        .onChange(of: viewModel.bookReview) { _, _ in
            viewModel.onReviewChanged(modelContext: modelContext, userId: coordinator.currentUserId)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Menu {
                        Button("Lidos") {
                            viewModel.markAsRead(modelContext: modelContext, userId: coordinator.currentUserId)
                        }
                        Button("Favoritos") {
                            viewModel.markAsFavorite(modelContext: modelContext, userId: coordinator.currentUserId)
                        }
                        Button("Não lidos") {
                            viewModel.markAsNotRead(modelContext: modelContext, userId: coordinator.currentUserId)
                        }
                        Button("Não gostei", role: .destructive) {
                            viewModel.markAsDisliked(modelContext: modelContext, userId: coordinator.currentUserId)
                        }
                    } label: {
                        Image(systemName: viewModel.isSavedToLibrary ? "bookmark.fill" : "bookmark")
                            .font(.title3)
                            .padding(.trailing, 15)
                            .tint(.primary)
                    }

                    Image(systemName: "square.and.arrow.up")
                        .font(.title3)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        BookDetailView(
            book: BookModel(
                id: "preview",
                title: "Preview",
                authors: ["Autor"],
                publishedDate: "2020",
                description: "Desc",
                pageCount: 100,
                categories: ["Ficção"],
                language: "pt",
                smallThumbnail: "",
                averageRating: 4
            )
        )
    }
    .appModelContainer(AppModelContainer.previewInMemory)
    .environment(AppCoordinator.previewLoggedIn())
}
