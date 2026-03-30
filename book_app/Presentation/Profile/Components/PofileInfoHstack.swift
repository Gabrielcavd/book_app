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
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    PofileInfoHstack(key: "Autor favorito:", value: "JK Rowling")
}
