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
    var emptyState: String = "Nao preenchido"

    private var isEmpty: Bool {
        value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        HStack(alignment: .center) {
            Text(key)
                .foregroundStyle(.secondary)
            Spacer()
            Text(isEmpty ? emptyState : value)
                .fontWeight(isEmpty ? .regular : .semibold)
                .foregroundStyle(isEmpty ? .secondary : .primary)
        }
    }
}

#Preview {
    PofileInfoHstack(key: "Autor favorito:", value: "JK Rowling")
}
