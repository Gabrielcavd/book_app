//
//  ConcurrentReading.swift
//  book_app
//
//  Created by Gabriel Merenfeld on 08/04/26.
//

import SwiftUI

struct CurrentReading: View {
    let seeMoreAction: () -> Void
    
    var body: some View {
        VStack {
            titleAndSeeMoreButtonRow
            DSCurrentReading()
        }
    }
    
    var titleAndSeeMoreButtonRow: some View {
        HStack {
            Text("Continuar lendo")
                .textStyle(.titleMedium)
            
            Spacer()
            
            Button("Ver mais", action: seeMoreAction)
                .foregroundColor(.blue)
                .textStyle(.titleSmall)
        }
    }
}

#Preview {
    CurrentReading(seeMoreAction: {})
}
