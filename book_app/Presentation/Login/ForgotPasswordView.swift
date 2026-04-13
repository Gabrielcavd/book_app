//
//  ForgotPasswordView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 12/04/26.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var email: String = ""
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 113, height: 53)

                Text("Recupere sua senha")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom, 28)

                TextFieldLabel(text: $email, label: "Email", titleKey: "Insira seu email")
                    .padding(.vertical, 15)              

                PrimaryButton(title: "Enviar link") {
                }
                .padding(EdgeInsets(top: 60, leading: 0, bottom: 20, trailing: 0))
            }
        }
        .padding()
    }
}

#Preview {
    ForgotPasswordView()
}
