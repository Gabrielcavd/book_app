//
//  Untitled.swift
//  book_app
//
//  Created by Gabriel Merenfeld on 08/04/26.
//

import SwiftUI

struct DSDefaultShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 0)
            .shadow(color: .black.opacity(0.02), radius: 20, x: 0, y: 6)
    }
}
