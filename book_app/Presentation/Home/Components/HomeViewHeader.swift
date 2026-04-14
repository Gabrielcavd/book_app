//
//  HomeViewHeader.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 30/03/26.
//

import SwiftUI

//TODO: - Pedir a foto do usuário no construtor também 

struct HomeViewHeader: View {
    let userName: String
    
    var body: some View {
        HStack(alignment: .center) {
            avatarImage
            textsColumn
        }
    }
    
    var avatarImage: some View {
        Image("avatar")
            .resizable()
            .scaledToFit()
            .frame(width: 60, height: 60)
            .clipShape(Circle())
    }
    
    var textsColumn: some View {
        VStack(alignment: .leading) {
            Text(userName)
                .textStyle(.titleMedium)
                .lineLimit(1)
            
            Text("Qual é a boa de hoje?")
                .textStyle(.body)
        }
    }
}

#Preview {
    HomeViewHeader(userName: "Gabriel Merenfeld")
}
