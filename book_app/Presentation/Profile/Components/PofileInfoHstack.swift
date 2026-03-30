//
//  PofileInfoHstack.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 30/03/26.
//

import SwiftUI

struct PofileInfoHstack: View {
    let key: String
    let value: String
    var body: some View {
        HStack(alignment: .center) {
            Text(key)
                .font(.headline)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .font(.headline)
        }
        .padding(.horizontal)
    }
}

#Preview {
    PofileInfoHstack(key: "Autor favorito:", value: "JK Rowling")
}
