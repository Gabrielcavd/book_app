//
//  BookInfo.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 07/03/26.
//

import SwiftUI

struct BookInfo: View {
    @Environment(AppCoordinator.self) private var coordinator
    var navigationStack: BookNavigationStack = .home

    var title: String? = nil
    var author: String? = nil

    var body: some View {
        Button {
            coordinator.pushBookDetail(on: navigationStack)
        } label: {
            VStack(alignment: .leading) {
                ZStack(alignment: .topTrailing) {
                    Image("book")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 103, height: 143)
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.orange)
                            .font(.caption)
                        Text("4.5")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    .padding(4)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.background)
                    )
                    .padding(5)
                }
                Text(title ?? "Senhor dos Aneis")
                    .fontWeight(.semibold)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
                Text(author ?? "J.R.R Tolkien")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(width: 110)
        }
        .buttonStyle(PressableButtonStyle())
    }
}

#Preview {
    BookInfo()
        .environment(AppCoordinator.previewLoggedIn())
}
