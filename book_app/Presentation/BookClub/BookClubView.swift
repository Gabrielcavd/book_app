//
//  BookClubView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 10/03/26.
//

import SwiftUI

struct BookClubView: View {
    @State private var selected: ClubTab = .leituras

    var body: some View {
        ZStack(alignment: .top) {
            Image("club")
                .resizable()
                .ignoresSafeArea()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

            VStack {
                Spacer().frame(height: 200)
                VStack(spacing: 16) {
                    Text("UFRN Club")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("Clube do Livro por Gabriel")
                        .foregroundStyle(.secondary)

                    Picker("", selection: $selected) {
                        Text("Leituras").tag(ClubTab.leituras)
                        Text("Chat").tag(ClubTab.chat)
                        Text("Votações").tag(ClubTab.votacoes)
                        Text("Membros").tag(ClubTab.membros)
                    }
                    .pickerStyle(.segmented)
                    switch selected {
                    case .leituras:
                        CurrentReading()
                    case .chat:
                        Text("Chat")
                    case .votacoes:
                        Text("Votações")
                    case .membros:
                        Text("Membros")
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.background)
                )
            }
        }
    }
}

enum ClubTab {
    case leituras
    case chat
    case votacoes
    case membros
}

#Preview {
    BookClubView()
}
