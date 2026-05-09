//
//  AppCoordinator.swift
//  book_app
//
//  Created by Gabriel Cavalcante on 07/04/26.
//

import SwiftUI

enum TabItem: Int, Hashable {
    case home
    case club
    case library
    case profile
}

enum AuthRoute: Hashable {
    case register
    case forgotPassword
}

enum BookRoute: Hashable {
    case detail(BookModel)
}

enum BookNavigationStack: Hashable {
    case home
    case library
}

@Observable
final class AppCoordinator {
    /// Active account; `nil` when logged out.
    var currentUserId: UUID?
    var isLoggedIn = false
    var selectedTab: TabItem = .home
    var authPath = NavigationPath()
    var homePath = NavigationPath()
    var libraryPath = NavigationPath()

    func restoreSession(activeUserId: UUID?) {
        currentUserId = activeUserId
        isLoggedIn = activeUserId != nil
    }

    func logIn(userId: UUID) {
        currentUserId = userId
        isLoggedIn = true
        authPath = NavigationPath()
    }

    func logOut() {
        currentUserId = nil
        isLoggedIn = false
        authPath = NavigationPath()
        homePath = NavigationPath()
        libraryPath = NavigationPath()
    }

    func showRegister() {
        authPath.append(AuthRoute.register)
    }

    func showForgotPassword() {
        authPath.append(AuthRoute.forgotPassword)
    }

    func pushBookDetail(on stack: BookNavigationStack, book: BookModel) {
        switch stack {
        case .home:
            homePath.append(BookRoute.detail(book))
        case .library:
            libraryPath.append(BookRoute.detail(book))
        }
    }
}

extension AppCoordinator {
    static func previewLoggedIn() -> AppCoordinator {
        let coordinator = AppCoordinator()
        coordinator.currentUserId = UUID()
        coordinator.isLoggedIn = true
        return coordinator
    }
}
