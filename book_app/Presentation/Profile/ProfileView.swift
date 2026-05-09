//
//  ProfileView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 30/03/26.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    @Environment(AppCoordinator.self) private var coordinator
    @Environment(\.modelContext) private var modelContext

    @State private var viewModel = ProfileViewModel()

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 24) {
                ProfileViewHeader(
                    fullName: viewModel.fullName.isEmpty ? "Perfil" : viewModel.fullName,
                    email: viewModel.email.isEmpty ? "" : viewModel.email,
                    profileImageName: viewModel.profileImageName,
                    profileImageData: viewModel.profileImageData
                ) {
                    viewModel.isShowingEditProfile = true
                }

                statsSection
                favoritesSection

                ProfileQuote(quote: viewModel.favoriteQuote)
                    .padding(.horizontal, -16)

                reviewsSection
            }
            .padding(.horizontal)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Sair") {
                    logOut()
                }
            }
        }
        .sheet(isPresented: $viewModel.isShowingEditProfile) {
            EditProfileView(
                data: viewModel.editableData,
                fallbackImageName: viewModel.profileImageName
            ) { updatedData in
                viewModel.updateProfile(
                    modelContext: modelContext,
                    userId: coordinator.currentUserId,
                    with: updatedData
                )
            }
        }
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

    private func logOut() {
        do {
            try AuthService(context: modelContext).logOut()
        } catch {}
        coordinator.logOut()
    }

    private var statsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 15) {
                ProfileFeaturedCard(image: "book.closed", title: "Lidos", value: viewModel.booksReadDisplay)
                ProfileFeaturedCard(image: "book", title: "Lendo", value: viewModel.booksReadingDisplay)
                ProfileFeaturedCard(image: "heart", title: "Lista", value: viewModel.wishlistDisplay)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }

    private var favoritesSection: some View {
        VStack(spacing: 16) {
            PofileInfoHstack(
                key: "Autor favorito:",
                value: viewModel.favoriteAuthor,
                emptyState: "Não informado"
            )
            PofileInfoHstack(
                key: "Paginas lidas:",
                value: viewModel.pagesRead.isEmpty ? "" : "\(viewModel.pagesRead) Paginas",
                emptyState: "Não informado"
            )
            PofileInfoHstack(
                key: "Genero favorito:",
                value: viewModel.favoriteGenre,
                emptyState: "Não informado"
            )
        }
    }

    private var reviewsSection: some View {
        VStack(alignment: .leading) {
            Text("Resenhas")
                .font(.title3)
                .fontWeight(.bold)

            if viewModel.hasReviews {
                ForEach(viewModel.reviews) { review in
                    ProfileReviewRow(review: review)
                }
            } else {
                ProfileEmptyReviews {
                    coordinator.selectedTab = .library
                }
            }
        }
    }
}

private struct ProfileReviewRow: View {
    let review: ProfileReview

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(review.title)
                .font(.subheadline.bold())
            HStack {
                ForEach(1 ... 5, id: \.self) { index in
                    Image(systemName: index <= review.rating ? "star.fill" : "star")
                        .foregroundStyle(.orange)
                        .font(.caption2)
                }
            }
            Text(review.content)
                .font(.subheadline)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 4)
        )
        .padding(.bottom, 8)
    }
}

#Preview {
    NavigationStack {
        ProfileView()
    }
    .appModelContainer(AppModelContainer.previewInMemory)
    .environment(AppCoordinator.previewLoggedIn())
}
