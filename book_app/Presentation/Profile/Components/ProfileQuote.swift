//
//  ProfileQuote.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 30/03/26.
//

import SwiftUI

struct ProfileQuote: View {
    let quote: String
    var author: String = ""
    var emptyStateMessage: String = "Adicione sua citacao favorita para personalizar seu perfil."

    private var hasQuote: Bool {
        !quote.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            if hasQuote {
                Text("\"\(quote)\"")
                    .multilineTextAlignment(.center)
                    .fontWeight(.semibold)

                if !author.isEmpty {
                    Text(author)
                        .font(.subheadline)
                }
            } else {
                Text(emptyStateMessage)
                    .multilineTextAlignment(.center)
                    .fontWeight(.semibold)
            }
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea(.all)
        .padding()
        .foregroundStyle(.background)
        .background(
            Color(.darkGray)
        )        
    }
}

#Preview {
    ProfileQuote(quote: "")
}
