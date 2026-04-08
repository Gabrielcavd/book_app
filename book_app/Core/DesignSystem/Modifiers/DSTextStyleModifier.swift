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
                
            case .titleMedium:
                content
                    .font(.system(size: 28))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
            case .titleSmall:
                content
                    .font(.system(size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
            
            case .body:
                content
                    .font(.system(size: 17))
                    .foregroundStyle(.secondary)
                
            case .caption:
                content
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
        }
    }
}
