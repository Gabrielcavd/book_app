//
//  ProfileFeaturedCard.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 30/03/26.
//

import SwiftUI

struct ProfileFeaturedCard: View {
    let image: String
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Image(systemName: image)
                .font(.title2)
            Text(value)
                .fontWeight(.bold)
            Text(title)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 30)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(.systemBackground))
                .shadow(
                    color: .black.opacity(0.08),
                    radius: 10,
                    x: 0,
                    y: 4
                )
        )
    }
}

#Preview {
    ProfileFeaturedCard(image: "book", title: "Lidos", value: "24")
}
