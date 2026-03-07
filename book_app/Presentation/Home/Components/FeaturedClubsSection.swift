//
//  FeaturedClubsSection.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 07/03/26.
//

import SwiftUI

struct FeaturedClubsSection: View {
    var body: some View {
        VStack {
            HStack {
                Text("Clubes que você participa")
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                Button("Ver todos") {
                }
                .font(.callout)
            }
            ForEach(0 ..< 3) { _ in
                HStack {
                    Image("club")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 68, height: 68)
                    VStack(alignment: .leading, spacing: 5) {
                        Text("TI Readings")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text("Descrição")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    Text("3")
                        .foregroundStyle(.white)
                        .padding()
                        .background(
                            Circle().fill(Color(.systemBlue))
                        )
                }
                .padding()
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
        .padding(.horizontal)
    }
}

#Preview {
    FeaturedClubsSection()
}
