//
//  RootView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 06/03/26.
//

import SwiftUI

struct RootAppView: View {
    @State private var coordinator = AppCoordinator()

    var body: some View {
        @Bindable var coordinator = coordinator
        Group {
            if coordinator.isLoggedIn {
                RootTabView()
            } else {
                NavigationStack(path: $coordinator.authPath) {
                    LoginView()
                        .navigationDestination(for: AuthRoute.self) { route in
                            switch route {
                            case .register:
                                RegisterView()
                            }
                        }
                }
            }
        }
        .environment(coordinator)
    }
}

#Preview {
    RootAppView()
}
