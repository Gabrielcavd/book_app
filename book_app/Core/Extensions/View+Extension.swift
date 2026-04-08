//
//  View+Extension.swift
//  book_app
//
//  Created by Gabriel Merenfeld on 06/04/26.
//

import SwiftUI

extension View {
    func textStyle(_ style: DSTextStyle) -> some View {
        self.modifier(DSTextStyleModifier(style: style))
    }
    
    func defaultShadow() -> some View {
        self.modifier(DSDefaultShadowModifier())
    }
}
