//
//  HomeViewHeader.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 30/03/26.
//

import SwiftUI

struct HomeViewHeader: View {
    var body: some View {
        HStack(alignment: .center) {
            Image("avatar")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text("Oi Gabriel!")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("O que você vai ler hoje?")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    HomeViewHeader()
}
