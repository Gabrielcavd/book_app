//
//  EditProfileView.swift
//  book_app
//
//  Created by Codex on 17/04/26.
//

import PhotosUI
import SwiftUI
import UIKit

struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: EditProfileViewModel
    @State private var selectedPhotoItem: PhotosPickerItem?

    private let fallbackImageName: String?
    private let onSave: (EditableProfileData) -> Void

    init(
        data: EditableProfileData,
        fallbackImageName: String?,
        onSave: @escaping (EditableProfileData) -> Void
    ) {
        _viewModel = State(initialValue: EditProfileViewModel(data: data))
        self.fallbackImageName = fallbackImageName
        self.onSave = onSave
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    photoSection
                    personalInfoSection
                    favoritesSection
                    quoteSection
                }
                .padding()
            }
            .navigationTitle("Editar perfil")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancelar") { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Salvar") {
                        saveProfile()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
        .onChange(of: selectedPhotoItem) { _, newItem in
            loadSelectedProfileImage(from: newItem)
        }
    }

    private var photoSection: some View {
        VStack(alignment: .center, spacing: 10) {
            profilePhotoPreview

            PhotosPicker(selection: $selectedPhotoItem, matching: .images, photoLibrary: .shared()) {
                Text("Escolher foto")
                    .fontWeight(.semibold)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.accentColor.opacity(0.12))
                    .cornerRadius(10)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }

    private var profilePhotoPreview: some View {
        Group {
            if let imageData = viewModel.profileImageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else if let fallbackImageName {
                Image(fallbackImageName)
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
    }

    private var personalInfoSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Informacoes pessoais")
                .font(.headline)

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
                text: $viewModel.email,
                label: "Email",
                titleKey: "Insira seu email",
                errorMessage: viewModel.emailError
            )
            .onChange(of: viewModel.email) { _, _ in
                viewModel.clearEmailError()
            }
        }
    }

    private var favoritesSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Preferencias")
                .font(.headline)

            TextFieldLabel(
                text: $viewModel.favoriteAuthor,
                label: "Autor favorito",
                titleKey: "Ex: Machado de Assis"
            )

            TextFieldLabel(
                text: $viewModel.pagesRead,
                label: "Paginas lidas",
                titleKey: "Ex: 1200",
                errorMessage: viewModel.pagesReadError
            )
            .onChange(of: viewModel.pagesRead) { _, _ in
                viewModel.clearPagesReadError()
            }

            TextFieldLabel(
                text: $viewModel.favoriteGenre,
                label: "Genero favorito",
                titleKey: "Ex: Fantasia"
            )
        }
    }

    private var quoteSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Citacao favorita")
                .font(.headline)

            TextFieldLabel(
                text: $viewModel.favoriteQuote,
                label: "Citacao",
                titleKey: "Digite sua citacao favorita"
            )
        }
    }

    private func saveProfile() {
        guard let updatedData = viewModel.makeProfileData() else { return }
        onSave(updatedData)
        dismiss()
    }

    private func loadSelectedProfileImage(from item: PhotosPickerItem?) {
        guard let item else { return }

        Task {
            guard let imageData = try? await item.loadTransferable(type: Data.self) else { return }
            await MainActor.run {
                viewModel.profileImageData = imageData
            }
        }
    }
}

#Preview {
    EditProfileView(
        data: EditableProfileData(
            fullName: "Gabriel Dantas",
            email: "gabriel@gmail.com",
            favoriteAuthor: "",
            pagesRead: "",
            favoriteGenre: "",
            favoriteQuote: "",
            profileImageData: nil
        ),
        fallbackImageName: "avatar"
    ) { _ in
    }
}
