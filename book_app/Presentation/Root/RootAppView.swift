//
//  RootView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 06/03/26.
//

import SwiftUI

struct RootAppView: View {
    @State private var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            RootTabView()
        } else {
            LoginView(isLoggedIn: $isLoggedIn)
        }
    }
}

#Preview {
    RootAppView()
}
