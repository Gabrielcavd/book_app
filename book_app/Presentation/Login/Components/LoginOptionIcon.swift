//
//  LoginOptionIcon.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 05/03/26.
//

import SwiftUI

struct LoginOptionIcon: View {
    let icon: String
    var body: some View {
        Image(icon)
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.gray.opacity(0.3), lineWidth: 1)
            }
    }
}

#Preview {
    LoginOptionIcon(icon: "google")
}
