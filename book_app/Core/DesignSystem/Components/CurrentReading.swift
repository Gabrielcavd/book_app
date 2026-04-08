//
//  CurrentReading.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 07/03/26.
//

import SwiftUI

// TODO: - Transformar em um botão e receber título, autor, páginas e a action no construtor

struct CurrentReading: View {
    var body: some View {
        HStack {
            bookImage
            VStack(alignment: .leading, spacing: 16) {
                titleAndAuthorColumn
                progressBookColumn
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(.systemBackground))
                .defaultShadow()
        )
        .defaultShadow()
    }
    
    var bookImage: some View {
        Image("book")
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 120)
    }
    
    var titleAndAuthorColumn: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Senhor dos anéis")
                .textStyle(.titleSmall)
                .lineLimit(2)
            
            Text("J.R.R Tolkien")
                .textStyle(.body)
        }
    }
    
    var progressBookColumn: some View {
        VStack(alignment: .leading, spacing: 8) {
            ProgressView(value: 0.8)
                .tint(.black)
            
            HStack {
                Text("80% completo")
                    .textStyle(.caption)
                
                Spacer()
                
                Text("Página 100 de 200")
                    .textStyle(.caption)
            }
        }
    }
}

#Preview {
    CurrentReading()
}
