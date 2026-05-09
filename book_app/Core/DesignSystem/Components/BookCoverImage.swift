//
//  BookCoverImage.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 09/05/26.
//
//  Reusable async cover from URL with placeholder fallback.
//

import SwiftUI

struct BookCoverImage: View {
    let url: URL?

    var body: some View {
        Group {
            if let url {
                AsyncImage(url: url) { phase in
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
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.secondary.opacity(0.15))
            Image(systemName: "photo")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }
}
