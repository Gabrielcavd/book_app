//
//  LibraryViewHeader.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 23/03/26.
//

import SwiftUI

struct LibraryViewHeader: View {
    let buttonAction: () -> Void
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Sua biblioteca")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("Todos os livros que você adicionou")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Button {
                buttonAction()
            } label: {
                Image(systemName: "plus")
                    .font(.title)
            }

        }
        
    }
}

#Preview {
    LibraryViewHeader(buttonAction: {})
}
