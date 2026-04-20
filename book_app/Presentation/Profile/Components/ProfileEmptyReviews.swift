//
//  ProfileEmptyReviews.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 17/04/26.
//

import SwiftUI

struct ProfileEmptyReviews: View {
    let onTap: () -> Void
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("Voce ainda nao tem resenhas.")
                .font(.subheadline)
                .fontWeight(.semibold)
            Text("Leia um livro e volte para compartilhar sua opiniao com a comunidade.")
                .font(.footnote)
                .foregroundStyle(.secondary)
            Button("Ir para Biblioteca") {
                onTap()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

#Preview {
    ProfileEmptyReviews(onTap: {})
}
