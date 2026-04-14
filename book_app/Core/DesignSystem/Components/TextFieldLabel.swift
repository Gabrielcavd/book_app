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
    var isSecure: Bool = false
    var errorMessage: String? = nil

    private var borderColor: Color {
        errorMessage == nil ? Color.secondary.opacity(0.5) : Color.red.opacity(0.8)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.subheadline)

            Group {
                if isSecure {
                    SecureField(titleKey, text: $text)
                } else {
                    TextField(titleKey, text: $text)
                }
            }
            .padding(15)
            .overlay(
                RoundedRectangle(cornerRadius: 7)
                    .stroke(borderColor, lineWidth: 1)
            )

            if let errorMessage, !errorMessage.isEmpty {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    @Previewable @State var email: String = ""
    TextFieldLabel(text: $email, label: "Email", titleKey: "Insira seu email")
}
