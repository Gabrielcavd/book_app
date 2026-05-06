//
//  AddBooksSheetBookCard.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 04/05/26.
//

import SwiftUI

struct AddBooksSheetBookCard: View {
    @Environment(AppCoordinator.self) private var coordinator

    var navigationStack: BookNavigationStack = .library
    let title: String
    let author: String
    let thumbnailURL: String?

    var body: some View {
        Button {
            coordinator.pushBookDetail(on: navigationStack)
        } label: {
            VStack(alignment: .leading) {
                ZStack(alignment: .topTrailing) {
                    coverImage
                        .frame(width: 103, height: 143)

                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.orange)
                            .font(.caption)
                        Text("4.5")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    .padding(4)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.background)
                    )
                    .padding(5)
                }

                Text(title)
                    .fontWeight(.semibold)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
                Text(author)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(width: 110)
        }
        .buttonStyle(PressableButtonStyle())
    }

    @ViewBuilder
    private var coverImage: some View {
        if let thumbnailURL, let imageURL = URL(string: thumbnailURL) {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    fallbackImage
                case .empty:
                    loadingPlaceholder
                @unknown default:
                    fallbackImage
                }
            }
        } else {
            fallbackImage
        }
    }

    private var loadingPlaceholder: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.secondary.opacity(0.15))
            ProgressView()
                .controlSize(.small)
        }
    }

    private var fallbackImage: some View {
        Image("book")
            .resizable()
            .scaledToFit()
    }
}

#Preview {
    AddBooksSheetBookCard(
        title: "Senhor dos Aneis",
        author: "J.R.R Tolkien",
        thumbnailURL: nil
    )
    .environment(AppCoordinator.previewLoggedIn())
}
