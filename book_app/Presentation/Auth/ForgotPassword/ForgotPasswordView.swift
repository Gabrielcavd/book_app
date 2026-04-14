//
//  ForgotPasswordView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 12/04/26.
//

import SwiftUI

struct ForgotPasswordView: View {
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
                }

                PrimaryButton(title: "Enviar link") {
                    viewModel.submitResetRequest()
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
