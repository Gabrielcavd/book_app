//
//  LibraryView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 15/03/26.
//

import SwiftUI

struct LibraryView: View {
    @State private var text: String = ""
    @State private var selected: LibraryTab = .todos
    @State private var showSheet: Bool = false
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 100)),
    ]
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(alignment: .center, spacing: 24) {
                    LibraryViewHeader {
                        showSheet.toggle()
                    }
                    TextField("Pesquise por autor ou título", text: $text)
                        .safeAreaInset(edge: .leading) { Image(systemName: "magnifyingglass") }
                        .padding(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(.secondary.opacity(0.5), lineWidth: 1)
                        )
                    Picker("", selection: $selected) {
                        Text("Todos").tag(LibraryTab.todos)
                        Text("Lidos").tag(LibraryTab.lidos)
                        Text("Favoritos").tag(LibraryTab.favoritos)
                        Text("Não lidos").tag(LibraryTab.naolidos)
                    }
                    .pickerStyle(.segmented)
                    switch selected {
                    case .todos:
                        LazyVGrid(columns: adaptiveColumn, spacing: 20) {
                            ForEach(1 ... 10, id: \.self) { _ in
                                BookInfo()
                            }
                        }
                    case .lidos:
                        Text("Nada por aqui")
                    case .favoritos:
                        Text("Favoritos")
                    case .naolidos:
                        Text("Não lidos")
                    }
                }
                .sheet(isPresented: $showSheet) {
                    VStack(alignment: .leading) {
                        Text("Adicionar livro")
                            .font(.headline)
                        Spacer()
                    }
                    .padding()
                    .presentationDetents([.medium, .large])
                }
            }
            .padding(.top)
            .padding(.horizontal)
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
    LibraryView()
}
