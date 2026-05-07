//
//  BookDetailInfo.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 25/03/26.
//

import SwiftUI

struct BookDetailInfo: View {
    let book: BookModel
    @Binding var bookReview: BookReview

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            nameAndAuthorBook

            RatingView(bookReview: $bookReview)

            CustomDropdownBookDetail(
                options: ReadingStatus.allCases,
                initialSelection: bookReview.readingStatus,
                bookReview: $bookReview
            )

            bookSpecs

            genreTexts
            descriptionTexts
        }
    }

    var nameAndAuthorBook: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(book.title)
                .textStyle(.titleMedium)
                .lineLimit(2)

            Text(book.primaryAuthorDisplay)
                .textStyle(.titleSmall)
                .padding(.bottom, 15)
        }
    }

    var bookSpecs: some View {
        HStack(alignment: .center, spacing: 4) {
            specColumn(
                icon: "building.columns",
                title: "Editora",
                value: "—",
                width: 130,
                iconSize: 31.5
            )

            specColumn(
                icon: "calendar",
                title: "Publicado em",
                value: book.formattedPublishedDate(),
                width: 150,
                iconSize: 36.5
            )

            specColumn(
                icon: "book",
                title: "Páginas",
                value: book.pageCountDisplay,
                width: 80,
                iconSize: 36.5
            )
        }
    }

    private func specColumn(icon: String, title: String, value: String, width: CGFloat, iconSize: CGFloat) -> some View {
        VStack(alignment: .center) {
            Image(systemName: icon)
                .font(.custom("title", size: iconSize))
                .foregroundStyle(.gray)

            Text(title)
                .textStyle(.body)

            Text(value)
                .textStyle(.titleSmall)
                .lineLimit(1)
        }
        .frame(width: width)
    }

    var genreTexts: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Gênero")
                .foregroundStyle(.gray)
                .textStyle(.titleSmall)

            Text(book.genresDisplay)
        }
    }

    var descriptionTexts: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Descrição")
                .foregroundStyle(.gray)
                .textStyle(.titleSmall)

            Text(book.descriptionDisplay)
                .foregroundColor(.primary)
                .textStyle(.body)
                .padding(.bottom, 6)
        }
    }
}
