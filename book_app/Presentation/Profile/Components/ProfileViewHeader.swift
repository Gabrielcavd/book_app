//
//  ProfileViewHeader.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 30/03/26.
//

import SwiftUI

struct ProfileViewHeader: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Perfil")
                .font(.title)
                .fontWeight(.bold)
            HStack(alignment: .center) {
                Image("avatar")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                VStack(alignment: .leading) {
                    Text("Gabriel Dantas")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("gabriel@gmail.com")
                        .tint(.secondary)
                    Button {
                        //
                    } label: {
                        Text("Editar")
                    }
                }
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    ProfileViewHeader()
}
