//
//  ProfileView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 30/03/26.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 24) {
                ProfileViewHeader()

                HStack(spacing: 15) {
                    ProfileFeaturedCard(image: "book.closed", title: "Lidos", value: "24")
                    ProfileFeaturedCard(image: "book", title: "Lendo", value: "2")
                    ProfileFeaturedCard(image: "heart", title: "Lista", value: "12")
                }
                .frame(maxWidth: .infinity, alignment: .center)

                PofileInfoHstack(key: "Autor favorito:", value: "JK Rowling")
                PofileInfoHstack(key: "Páginas lidas:", value: "15200 Páginas")
                PofileInfoHstack(key: "Gênero favorito:", value: "Fantasia")

                ProfileQuote()
                    .padding(.horizontal, -16)
                
                VStack(alignment: .leading) {
                    Text("Resenhas")
                        .font(.title3)
                        .fontWeight(.bold)
                    BookDetailComments()
                    BookDetailComments()
                    BookDetailComments()
                    
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ProfileView()
}
