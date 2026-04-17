//
//  BookDetailInfo.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 25/03/26.
//

import SwiftUI

struct BookDetailInfo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            nameAndAuthorBook
            bookSpecs
            
            genreTexts
            descriptionTexts
        }
    }
    
    var nameAndAuthorBook: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Senhor do Anéis")
                .textStyle(.titleMedium)
                .lineLimit(2)
            
            Text("J.R.R Tolkien")
                .textStyle(.titleSmall)
                .padding(.bottom, 15)
        }
    }
    
    var bookSpecs: some View {
        HStack {
            specItem(icon: "building.columns", title: "Editora", value: "HarperCollins")
            specItem(icon: "calendar", title: "Publicado em", value: "15 janeiro 2023")
            specItem(icon: "book", title: "Páginas", value: "192")
        }
    }
    
    private func specItem(icon: String, title: String, value: String) -> some View {
        VStack {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundStyle(.gray)
            
            Text(title)
                .textStyle(.body)
            
            Text(value)
                .textStyle(.titleSmall)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, maxHeight: 80)
    }
    
    var genreTexts: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Gênero")
                .foregroundStyle(.gray)
                .textStyle(.titleSmall)
            
            Text("Fantasia, Horror, Ficção Ciêntífica")
        }
    }
    
    var descriptionTexts: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Descrição")
                .foregroundStyle(.gray)
                .textStyle(.titleSmall)
            
            Text("O Senhor dos Anéis é um livro de alta fantasia, escrito pelo escritor britânico J. R. R. Tolkien. Escrita entre 1937 e 1949, com muitas partes criadas durante a Segunda Guerra Mundial, a saga é uma continuação de O Hobbit.")
                .foregroundColor(.black)
                .textStyle(.body)
                .padding(.bottom, 6)
        }
    }
}

#Preview {
    BookDetailInfo()
}
