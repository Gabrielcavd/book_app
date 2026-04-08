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
}

enum BookRoute: Hashable {
    case detail
}

/// Which navigation stack should receive book-detail pushes (used by `BookInfo`).
enum BookNavigationStack: Hashable {
    case home
    case library
}

@Observable
final class AppCoordinator {
    var isLoggedIn = false
    var selectedTab: TabItem = .home
    var authPath = NavigationPath()
    var homePath = NavigationPath()
    var libraryPath = NavigationPath()

    func logIn() {
        isLoggedIn = true
        authPath = NavigationPath()
    }

    func logOut() {
        isLoggedIn = false
        authPath = NavigationPath()
        homePath = NavigationPath()
        libraryPath = NavigationPath()
    }

    func showRegister() {
        authPath.append(AuthRoute.register)
    }

    func pushBookDetail(on stack: BookNavigationStack) {
        switch stack {
        case .home:
            homePath.append(BookRoute.detail)
        case .library:
            libraryPath.append(BookRoute.detail)
        }
    }
}

extension AppCoordinator {
    static func previewLoggedIn() -> AppCoordinator {
        let coordinator = AppCoordinator()
        coordinator.isLoggedIn = true
        return coordinator
    }
}
