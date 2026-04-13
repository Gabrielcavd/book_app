//
//  LoginView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 05/03/26.
//

import SwiftUI

struct LoginView: View {
    @Environment(AppCoordinator.self) private var coordinator

    @State private var viewModel = LoginViewModel()

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 113, height: 53)

                Text("Faça login na\n sua conta.")
                    .font(.largeTitle)
                    .fontWeight(.semibold)

                TextFieldLabel(
                    text: $viewModel.email,
                    label: "Email",
                    titleKey: "Insira seu email",
                    errorMessage: viewModel.emailError
                )
                .padding(.vertical, 28)
                .onChange(of: viewModel.email) { _, _ in
                    viewModel.clearEmailError()
                }

                TextFieldLabel(
                    text: $viewModel.password,
                    label: "Senha",
                    titleKey: "Insira sua senha",
                    isSecure: true,
                    errorMessage: viewModel.passwordError
                )
                .onChange(of: viewModel.password) { _, _ in
                    viewModel.clearPasswordError()
                }

                Button("Esqueceu sua senha?") {
                    coordinator.showForgotPassword()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)

                PrimaryButton(title: "Entrar") {
                    viewModel.logIn(using: coordinator)
                }
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
                    coordinator.showRegister()
                }
                .frame(maxWidth: .infinity)
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
        .environment(AppCoordinator())
}
