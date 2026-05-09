//
//  LibraryView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 15/03/26.
//

import SwiftUI
import SwiftData

struct LibraryView: View {
    @Environment(AppCoordinator.self) private var coordinator
    @Environment(\.modelContext) private var modelContext

    @State private var viewModel = LibraryViewModel()
    @State private var showSheet: Bool = false
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 100), alignment: .top),
    ]

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .center, spacing: 24) {
                LibraryViewHeader {
                    showSheet.toggle()
                }
                TextField("Pesquise por autor ou título", text: $viewModel.searchText)
                    .safeAreaInset(edge: .leading) { Image(systemName: "magnifyingglass") }
                    .padding(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(.secondary.opacity(0.5), lineWidth: 1)
                    )
                Picker("", selection: $viewModel.selectedTab) {
                    Text("Todos").tag(LibraryTab.todos)
                    Text("Lidos").tag(LibraryTab.lidos)
                    Text("Favoritos").tag(LibraryTab.favoritos)
                    Text("Não lidos").tag(LibraryTab.naolidos)
                }
                .pickerStyle(.segmented)
                if viewModel.filteredBooks.isEmpty {
                    VStack(spacing: 12) {
                        Text(viewModel.emptyStateMessage)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                        if viewModel.selectedTab == .todos,
                           viewModel.searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            Button("Adicionar livros") {
                                showSheet = true
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                    .padding(.top, 12)
                } else {
                    LazyVGrid(columns: adaptiveColumn, alignment: .center, spacing: 20) {
                        ForEach(viewModel.filteredBooks) { item in
                            BookInfo(
                                navigationStack: .library,
                                book: item.book
                            )
                        }
                    }
                }
            }
            .sheet(isPresented: $showSheet) {
                AddBooksSheetView()
            }
        }
        .padding(.top)
        .padding(.horizontal)
        .onAppear {
            viewModel.refresh(modelContext: modelContext, userId: coordinator.currentUserId)
        }
        .onChange(of: coordinator.currentUserId) { _, _ in
            viewModel.refresh(modelContext: modelContext, userId: coordinator.currentUserId)
        }
        .onChange(of: viewModel.selectedTab) { _, _ in
            viewModel.refresh(modelContext: modelContext, userId: coordinator.currentUserId)
        }
        .onChange(of: viewModel.searchText) { _, _ in
            viewModel.refresh(modelContext: modelContext, userId: coordinator.currentUserId)
        }
        .onChange(of: showSheet) { _, isPresented in
            if !isPresented {
                viewModel.refresh(modelContext: modelContext, userId: coordinator.currentUserId)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .savedBooksDidChange)) { _ in
            viewModel.refresh(modelContext: modelContext, userId: coordinator.currentUserId)
        }
    }
}

enum LibraryTab {
    case todos
    case lidos
    case favoritos
    case naolidos
}

#Preview {
    NavigationStack {
        LibraryView()
    }
    .appModelContainer(AppModelContainer.previewInMemory)
    .environment(AppCoordinator.previewLoggedIn())
}
