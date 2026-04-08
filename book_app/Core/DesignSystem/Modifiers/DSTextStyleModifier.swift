//
//  DSTextStyles.swift
//  book_app
//
//  Created by Gabriel Merenfeld on 06/04/26.
//

import SwiftUI

struct DSTextStyleModifier: ViewModifier {
    let style: DSTextStyle
    
    func body(content: Content) -> some View {
        switch style {
            case .titleLarge:
                content
                    .font(.system(size: 56))
                    .fontWeight(.black)
                    .foregroundColor(.black)
                    .lineSpacing(64)
                
            case .title:
                content
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .lineSpacing(32)
                
            case .body:
                content
                    .font(.system(size: 16))
                    .foregroundStyle(.secondary)
                    .lineSpacing(24)
                
            case .caption:
                content
                    .font(.system(size: 12))
                    .foregroundStyle(.secondary)
                    .lineSpacing(20)
        }
    }
}
