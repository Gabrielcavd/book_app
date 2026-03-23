//
//  LibraryViewHeader.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 23/03/26.
//

import SwiftUI

struct LibraryViewHeader: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Sua biblioteca")
                .font(.title2)
                .fontWeight(.bold)
            Text("Todos os livros que você adicionou")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    LibraryViewHeader()
}
