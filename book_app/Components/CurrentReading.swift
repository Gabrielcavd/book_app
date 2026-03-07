//
//  CurrentReading.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 07/03/26.
//

import SwiftUI

struct CurrentReading: View {
    var body: some View {
        HStack {
            Image("book")
                .resizable()
                .scaledToFit()
                .frame(width: 76, height: 98)
            VStack(alignment: .leading, spacing: 5) {
                Text("LEITURA ATUAL")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("Senhor dos anéis")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text("J.R.R Tolkien")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                HStack {
                    ProgressView(value: 0.8)
                    Text("80%")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
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
        .padding(.horizontal)
        
    }
}

#Preview {
    CurrentReading()
}
