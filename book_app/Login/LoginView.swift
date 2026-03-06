//
//  ContentView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 05/03/26.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 113, height: 53)

                    Text("Faça login na\n sua conta.")
                        .font(.largeTitle)
                        .fontWeight(.semibold)

                    TextFieldLabel(text: $email, label: "Email", titleKey: "Insira seu email")
                        .padding(.vertical, 28)

                    TextFieldLabel(text: $password, label: "Senha", titleKey: "Insira sua senha")

                    Button("Esqueceu sua senha?") {
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)

                    NavigationLink(destination: PreferencesView(), label: {
                        PrimaryButton(title: "Entrar") {
                        }
                    })
                    .padding(EdgeInsets(top: 30, leading: 0, bottom: 20, trailing: 0))

                    HStack {
                        line
                        Text("Ou entre com")
                            .foregroundStyle(.gray)
                        line
                    }
                    .padding(.bottom, 28)

                    HStack(alignment: .center) {
                        LoginOptionIcon(icon: "google")
                            .padding(.trailing, 16)
                        LoginOptionIcon(icon: "apple")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 28)

                    Button("Ainda não tem uma conta?") {
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding()
    }

    private var line: some View {
        VStack { Divider().background(.gray) }.padding(10)
    }
}

#Preview {
    LoginView()
}
