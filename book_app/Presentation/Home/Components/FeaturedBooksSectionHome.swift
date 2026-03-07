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
                    .font(.title3)
                    .fontWeight(.semibold)
                Spacer()
                Button("Ver mais") {
                }
                .font(.callout)
            }
            .padding(.horizontal)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0 ..< 4) { _ in
                        BookInfo()
                            .padding(.horizontal, 5)
                    }
                }
            }
            .padding(.leading)
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    FeaturedBooksSectionHome()
}
