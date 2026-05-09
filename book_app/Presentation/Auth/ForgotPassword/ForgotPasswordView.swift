//
//  ForgotPasswordView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 12/04/26.
//

import SwiftUI
import SwiftData

struct ForgotPasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var viewModel = ForgotPasswordViewModel()

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

                TextFieldLabel(
                    text: $viewModel.email,
                    label: "Email",
                    titleKey: "Insira seu email",
                    errorMessage: viewModel.emailError
                )
                .padding(.vertical, 15)
                .onChange(of: viewModel.email) { _, _ in
                    viewModel.clearEmailError()
                    viewModel.clearFormError()
                }

                TextFieldLabel(
                    text: $viewModel.newPassword,
                    label: "Nova senha",
                    titleKey: "Insira a nova senha",
                    isSecure: true,
                    errorMessage: viewModel.newPasswordError
                )
                .padding(.vertical, 8)
                .onChange(of: viewModel.newPassword) { _, _ in
                    viewModel.clearNewPasswordError()
                    viewModel.clearConfirmPasswordError()
                    viewModel.clearFormError()
                }

                TextFieldLabel(
                    text: $viewModel.confirmPassword,
                    label: "Confirmar nova senha",
                    titleKey: "Confirme a nova senha",
                    isSecure: true,
                    errorMessage: viewModel.confirmPasswordError
                )
                .onChange(of: viewModel.confirmPassword) { _, _ in
                    viewModel.clearConfirmPasswordError()
                    viewModel.clearFormError()
                }

                if let formError = viewModel.formError {
                    Text(formError)
                        .font(.footnote)
                        .foregroundStyle(.red)
                }

                if let success = viewModel.successMessage {
                    Text(success)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                PrimaryButton(title: "Atualizar senha") {
                    if viewModel.submitResetRequest(modelContext: modelContext) {
                        dismiss()
                    }
                }
                .padding(EdgeInsets(top: 40, leading: 0, bottom: 20, trailing: 0))
            }
        }
        .padding()
    }
}

#Preview {
    ForgotPasswordView()
}
