//
//  FeaturedSectionHome.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 07/03/26.
//

import SwiftUI

struct FeaturedBooksSectionHome: View {
    var body: some View {
        VStack {
            HStack {
                Text("Destaques")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Button("Ver mais") {
                }
                .font(.footnote)
            }
            .padding(.horizontal)
            ScrollView(.horizontal) {
                HStack {
                    BookInfo(book: .previewStub)
                        .padding(.horizontal, 5)
                }
            }
            .padding(.leading)
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    FeaturedBooksSectionHome()
        .environment(AppCoordinator.previewLoggedIn())
}
