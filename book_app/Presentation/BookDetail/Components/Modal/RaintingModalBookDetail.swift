//
//  Untitled.swift
//  book_app
//
//  Created by Gabriel Merenfeld on 28/04/26.
//

import SwiftUI

struct RaintingModalBookDetail: View {
    let bookId: String
    let titles: [Int: String]
    @Binding var bookReview: BookReview
    
    @Environment(\.dismiss) private var dismiss
    @State private var opinion: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Text("Avaliação")
                    .textStyle(.titleMedium)
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.black)
                        .frame(width: 44, height: 44)
                        .background(
                            Circle()
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
            }
            .padding(.top, 24)
            
            raiting
            insertOpinion
            
            saveButton
                .padding(.bottom, 16)
        }
        .padding(.horizontal, 16)
    }
    
    var raiting: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Nota")
                .textStyle(.titleSmall)
            
            HStack(spacing: 8) {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: index <= bookReview.rating ? "star.fill" : "star")
                        .font(.system(size: 30))
                        .foregroundColor(index <= bookReview.rating ? .yellow : .gray)
                        .onTapGesture {
                            bookReview.rating = index
                        }
                }
                
                Text(titles[bookReview.rating] ?? "sem avaliação")
                    .font(.system(size: 18))
                    .foregroundColor(.gray)
            }
        }
    }
    
    var insertOpinion: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Opinião")
                .textStyle(.titleSmall)
            
            TextEditor(text: $opinion)
                .padding(12)
                .frame(height: 140)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                .overlay(alignment: .topLeading) {
                    if opinion.isEmpty {
                        Text("Escreva o que você achou do livro...")
                            .foregroundColor(.gray)
                            .padding(.top, 20)
                            .padding(.leading, 18)
                            .allowsHitTesting(false)
                    }
                }
        }
    }
    
    var saveButton: some View {
        Button {
            bookReview.createdAt = Date()
            bookReview.opinion = opinion
            dismiss()
        } label: {
            Text("Salvar")
                .foregroundColor(.white)
                .textStyle(.titleSmall)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.black)
                )
        }
    }
}
