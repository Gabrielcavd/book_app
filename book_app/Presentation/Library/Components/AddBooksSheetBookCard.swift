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
    let book: BookModel

    var body: some View {
        Button {
            coordinator.pushBookDetail(on: navigationStack, book: book)
        } label: {
            VStack(alignment: .leading) {
                ZStack(alignment: .topTrailing) {
                    BookCoverImage(url: book.coverImageURL)
                        .frame(width: 103, height: 143)

                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.orange)
                            .font(.caption)
                        Text(book.averageRatingLabel)
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

                Text(book.title)
                    .fontWeight(.semibold)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
                Text(book.primaryAuthorDisplay)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(width: 110)
        }
        .buttonStyle(PressableButtonStyle())
    }
}

#Preview {
    AddBooksSheetBookCard(book: .previewStub)
        .environment(AppCoordinator.previewLoggedIn())
}
