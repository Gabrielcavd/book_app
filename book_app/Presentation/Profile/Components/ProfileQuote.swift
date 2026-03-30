//
//  ProfileQuote.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 30/03/26.
//

import SwiftUI

struct ProfileQuote: View {
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("“A felicidade pode ser encontrada mesmo nos momentos mais sombrios, se a pessoa se lembrar de acender a luz”")
                .fontWeight(.semibold)
            Text("Alvo Dumbledore")
                .font(.subheadline)
        }
        .padding()
        .foregroundStyle(.background)
        .background(
            Color(.darkGray)
        )
        .ignoresSafeArea(edges: .all)
    }
}

#Preview {
    ProfileQuote()
}
