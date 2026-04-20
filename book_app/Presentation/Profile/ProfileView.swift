//
//  ProfileView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 30/03/26.
//

import SwiftUI

struct ProfileView: View {
    @Environment(AppCoordinator.self) private var coordinator
    @State private var viewModel = ProfileViewModel()

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 24) {
                ProfileViewHeader(
                    fullName: viewModel.fullName,
                    email: viewModel.email,
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
        .sheet(isPresented: $viewModel.isShowingEditProfile) {
            EditProfileView(
                data: viewModel.editableData,
                fallbackImageName: viewModel.profileImageName
            ) { updatedData in
                viewModel.updateProfile(with: updatedData)
            }
        }
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
                ForEach(viewModel.reviews) { _ in
                    BookDetailComments()
                }
            } else {
                ProfileEmptyReviews {
                    coordinator.selectedTab = .library
                }
            }
        }
    }
}

#Preview {
    ProfileView()
        .environment(AppCoordinator.previewLoggedIn())
}
