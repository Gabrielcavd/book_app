//
//  TextFieldLabel.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 05/03/26.
//

import SwiftUI

struct TextFieldLabel: View {
    @Binding var text: String
    let label: String
    let titleKey: String
    let isPassWord: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.subheadline)

            if isPassWord {
                SecureField(titleKey, text: $text)
                    .padding(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(.secondary.opacity(0.5), lineWidth: 1)
                    )
            } else {
                TextField(titleKey, text: $text)
                    .padding(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(.secondary.opacity(0.5), lineWidth: 1)
                    )
            }
        }
    }
}

#Preview {
    @Previewable @State var email: String = ""
    TextFieldLabel(text: $email, label: "Email", titleKey: "Insira seu email")
}
