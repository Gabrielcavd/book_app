//
//  RegisterView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 28/03/26.
//

import PhotosUI
import SwiftData
import SwiftUI
import UIKit

struct RegisterView: View {
    @Environment(AppCoordinator.self) private var coordinator
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var viewModel = RegisterViewModel()
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var selectedProfileImage: Image?
    @State private var selectedAvatarData: Data?

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 113, height: 53)

                Text("Crie sua conta.")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom, 28)

                profilePictureSection
                    .padding(.bottom, 20)

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

                if let formError = viewModel.formError {
                    Text(formError)
                        .font(.footnote)
                        .foregroundStyle(.red)
                }

                PrimaryButton(title: "Registrar") {
                    if viewModel.register(
                        modelContext: modelContext,
                        coordinator: coordinator,
                        avatarData: selectedAvatarData
                    ) {
                        dismiss()
                    }
                }
                .padding(EdgeInsets(top: 60, leading: 0, bottom: 20, trailing: 0))
            }
        }
        .padding()
        .onChange(of: selectedPhotoItem) { _, newItem in
            loadSelectedProfileImage(from: newItem)
        }
    }

    private var profilePictureSection: some View {
        VStack(alignment: .center ,spacing: 16) {
            Group {
                if let selectedProfileImage {
                    selectedProfileImage
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(.gray.opacity(0.6))
                }
            }
            .frame(width: 90, height: 90)
            .background(Color.gray.opacity(0.15))
            .clipShape(Circle())

            PhotosPicker(
                selection: $selectedPhotoItem,
                matching: .images,
                photoLibrary: .shared()
            ) {
                Text("Escolher foto de perfil")
                    .fontWeight(.semibold)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.accentColor.opacity(0.12))
                    .cornerRadius(10)
            }
        }.frame(maxWidth: .infinity, alignment: .center)
    }

    private func loadSelectedProfileImage(from item: PhotosPickerItem?) {
        guard let item else {
            selectedProfileImage = nil
            selectedAvatarData = nil
            return
        }

        Task {
            guard
                let imageData = try? await item.loadTransferable(type: Data.self),
                let uiImage = UIImage(data: imageData)
            else {
                await MainActor.run {
                    selectedProfileImage = nil
                    selectedAvatarData = nil
                }
                return
            }

            await MainActor.run {
                selectedProfileImage = Image(uiImage: uiImage)
                selectedAvatarData = imageData
            }
        }
    }
}

#Preview {
    RegisterView()
        .appModelContainer(AppModelContainer.previewInMemory)
        .environment(AppCoordinator())
}
