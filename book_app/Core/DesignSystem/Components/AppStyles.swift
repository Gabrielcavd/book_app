//
//  AppStyles.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 23/03/26.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
}
