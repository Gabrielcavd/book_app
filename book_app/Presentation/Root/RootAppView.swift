//
//  RootView.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 06/03/26.
//

import SwiftData
import SwiftUI

struct RootAppView: View {
    @Environment(\.modelContext) private var modelContext
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
                            case .forgotPassword:
                                ForgotPasswordView()
                            }
                        }
                }
            }
        }
        .environment(coordinator)
        .task {
            await restoreSessionIfNeeded()
        }
    }

    @MainActor
    private func restoreSessionIfNeeded() async {
        do {
            let id = try SessionRepository(context: modelContext).activeUserId()
            if let id {
                let exists = UserRepository(context: modelContext).fetchUser(byId: id) != nil
                coordinator.restoreSession(activeUserId: exists ? id : nil)
                if !exists {
                    try SessionRepository(context: modelContext).clearSession()
                }
            } else {
                coordinator.restoreSession(activeUserId: nil)
            }
        } catch {
            coordinator.restoreSession(activeUserId: nil)
        }
    }
}

#Preview {
    RootAppView()
}
