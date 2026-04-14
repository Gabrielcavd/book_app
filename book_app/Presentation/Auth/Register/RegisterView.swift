//
//  RegisterView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 28/03/26.
//

import SwiftUI

struct RegisterView: View {
    @State private var viewModel = RegisterViewModel()

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

                TextFieldLabel(
                    text: $viewModel.email,
                    label: "Email",
                    titleKey: "Insira seu email",
                    errorMessage: viewModel.emailError
                )
                .padding(.vertical, 15)
                .onChange(of: viewModel.email) { _, _ in
                    viewModel.clearEmailError()
                }

                TextFieldLabel(
                    text: $viewModel.fullName,
                    label: "Nome completo",
                    titleKey: "Insira seu nome",
                    errorMessage: viewModel.fullNameError
                )
                .onChange(of: viewModel.fullName) { _, _ in
                    viewModel.clearFullNameError()
                }

                TextFieldLabel(
                    text: $viewModel.password,
                    label: "Senha",
                    titleKey: "Insira sua senha",
                    isSecure: true,
                    errorMessage: viewModel.passwordError
                )
                .padding(.vertical, 15)
                .onChange(of: viewModel.password) { _, _ in
                    viewModel.clearPasswordError()
                    viewModel.clearConfirmPasswordError()
                }

                TextFieldLabel(
                    text: $viewModel.confirmPassword,
                    label: "Confirmar senha",
                    titleKey: "Confirme sua senha",
                    isSecure: true,
                    errorMessage: viewModel.confirmPasswordError
                )
                .onChange(of: viewModel.confirmPassword) { _, _ in
                    viewModel.clearConfirmPasswordError()
                }

                PrimaryButton(title: "Registrar") {
                    viewModel.register()
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
