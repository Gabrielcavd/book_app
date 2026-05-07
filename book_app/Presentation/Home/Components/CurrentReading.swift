//
//  CurrentReading.swift
//  book_app
//
//  Created by Gabriel Merenfeld on 10/04/26.
//

import SwiftUI

struct CurrentReading: View {
    var seeMoreAction: () -> Void

    var body: some View {
        VStack(spacing: 8) {
            titleAndSeeMoreButtonRow
            DSCurrentReading()
        }
    }

    var titleAndSeeMoreButtonRow: some View {
        HStack {
            Text("Continuar lendo")
                .textStyle(.titleSmall)

            Spacer()
        }
    }
}

#Preview {
    CurrentReading(seeMoreAction: {})
}
