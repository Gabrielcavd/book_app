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
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 100)),
    ]
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading) {
                    Text("Sua biblioteca")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Todos os livros que você adicionou")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
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
                    Text("Lidos")
                case .favoritos:
                    Text("Favoritos")
                case .naolidos:
                    Text("Não lidos")
                }
               
            }
        }
        .padding(.top)
        .padding(.horizontal)
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
