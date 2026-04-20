//
//  ProfileViewHeader.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 30/03/26.
//

import SwiftUI
import UIKit

struct ProfileViewHeader: View {
    let fullName: String
    let email: String
    let profileImageName: String?
    let profileImageData: Data?
    let onEditTap: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text("Perfil")
                .font(.title2)
                .fontWeight(.bold)
            HStack(alignment: .center) {
                avatarImage
                VStack(alignment: .leading) {
                    Text(fullName)
                        .font(.title3)
                        .fontWeight(.bold)
                    Text(email)
                        .tint(.secondary)
                    Button {
                        onEditTap()
                    } label: {
                        Text("Editar")
                    }
                }
            }
        }
        .padding(.vertical)
    }

    private var avatarImage: some View {
        Group {
            if let profileImageData, let uiImage = UIImage(data: profileImageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else if let profileImageName {
                Image(profileImageName)
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle(.gray.opacity(0.7))
            }
        }
        .frame(width: 60, height: 60)
        .background(Color.gray.opacity(0.15))
        .clipShape(Circle())
    }
}

#Preview {
    ProfileViewHeader(
        fullName: "Gabriel Dantas",
        email: "gabriel@gmail.com",
        profileImageName: "avatar",
        profileImageData: nil,
        onEditTap: {}
    )
}
