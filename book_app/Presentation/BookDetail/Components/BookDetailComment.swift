//
//  BookDetailComments.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 25/03/26.
//

import SwiftUI

struct BookDetailComments: View {
    var body: some View {
        HStack(alignment: .top) {
            Text("GC")
                .font(.subheadline.bold())
                .padding()
                .background(
                    Circle()
                        .fill(.secondary)
                )
            VStack(alignment: .leading) {
                Text("Gabriel Cavalcante")
                    .font(.subheadline.bold())
                    .padding(.bottom, 4)
                HStack {
                    ForEach(1 ..< 5) { _ in
                        Image(systemName: "star.fill")
                            .foregroundStyle(.orange)
                            .font(.caption2)
                    }
                }
                .padding(.bottom, 4)

                Text("One of the best classics I've ever read! The character development is absolutely brilliant.")
                    .font(.subheadline)
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
        .padding(.bottom)

    }
}

#Preview {
    BookDetailComments()
}
