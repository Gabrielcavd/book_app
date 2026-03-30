//
//  RegisterView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 28/03/26.
//

import SwiftUI

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 113, height: 53)

                Text("Crie sua conta.")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom, 28)

                TextFieldLabel(text: $email, label: "Email", titleKey: "Insira seu email")
                TextFieldLabel(text: $password, label: "Senha", titleKey: "Insira sua senha")
                    .padding(.vertical, 15)
                TextFieldLabel(text: $confirmPassword, label: "Confirmar senha", titleKey: "Confirme sua senha")


                PrimaryButton(title: "Registrar") {
                    
                }
                .padding(EdgeInsets(top: 60, leading: 0, bottom: 20, trailing: 0))
           
            }
        }
        .padding()
    }
}

#Preview {
    RegisterView()
}
