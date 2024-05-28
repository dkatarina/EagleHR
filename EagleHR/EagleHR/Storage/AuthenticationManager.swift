//
// Created by Katarina Dokic
//

import Foundation
import Combine

struct AuthenticationManager {
    static let shared = AuthenticationManager()

    private let keychainManager = KeychainManager.shared
    private let authorizationTokenKey = "authorizationToken"

    let isAuthenticated = CurrentValueSubject<IsAuthenticated, Never>(.checking)

    init() {
        hasAuthenticated()
    }

    private func hasAuthenticated() {
        let splashScreenAnimationDuration = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + splashScreenAnimationDuration) {
            let hasAuthenticated: IsAuthenticated = if getAuthToken() != nil {
                .authenticated
            } else {
                .notAuthenticated
            }
            isAuthenticated.send(hasAuthenticated)
        }
    }

    func saveAuthToken(_ token: String) {
        if (!keychainManager.store(token, key: authorizationTokenKey)) {
            assertionFailure("Failed to save authorization token")
        }
        DispatchQueue.main.async {
            isAuthenticated.send(.authenticated)
        }
    }

    func removeAuthToken() throws {
        keychainManager.remove(key: authorizationTokenKey)
        isAuthenticated.send(.notAuthenticated)
    }

    func getAuthToken() -> String? {
        keychainManager.get(key: authorizationTokenKey)
    }
}

enum IsAuthenticated {
    case checking
    case notAuthenticated
    case authenticated
}
