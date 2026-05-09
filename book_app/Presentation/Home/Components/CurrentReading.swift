//
//  CurrentReading.swift
//  book_app
//
//  Created by Gabriel Merenfeld on 10/04/26.
//

import SwiftUI

struct CurrentReading: View {
    let book: BookModel?
    var seeMoreAction: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            titleAndSeeMoreButtonRow
            DSCurrentReading(book: book)
        }
    }

    var titleAndSeeMoreButtonRow: some View {
        HStack {
            Text("Continuar lendo")
                .textStyle(.titleSmall)

            Spacer()
        }
    }
}

#Preview {
    CurrentReading(book: nil, seeMoreAction: {})
}
