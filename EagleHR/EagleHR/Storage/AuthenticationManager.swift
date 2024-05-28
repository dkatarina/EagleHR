//
// Created by Katarina Dokic
//

import Foundation
import Combine

struct AuthenticationManager {
    static let shared = AuthenticationManager()

    private let keychainManager = KeychainManager.shared
    private let defaults = UserDefaults.standard
    private let authorizationTokenKey = "authorizationToken"
    private let userIdKey = "userId"

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

    private func removeAuthToken() {
        keychainManager.remove(key: authorizationTokenKey)
        isAuthenticated.send(.notAuthenticated)
    }

    private func removeUserId() {
        defaults.removeObject(forKey: userIdKey)
    }

    func saveAuthToken(_ token: String) {
        if (!keychainManager.store(token, key: authorizationTokenKey)) {
            assertionFailure("Failed to save authorization token")
        }
        DispatchQueue.main.async {
            isAuthenticated.send(.authenticated)
        }
    }

    func logout() {
        removeUserId()
        removeAuthToken()
    }

    func getAuthToken() -> String? {
        keychainManager.get(key: authorizationTokenKey)
    }

    func saveUserId(_ userId: Int) {
        defaults.set(userId, forKey: userIdKey)
    }

    func getUserId() -> Int {
        defaults.integer(forKey: userIdKey)
    }
}

enum IsAuthenticated {
    case checking
    case notAuthenticated
    case authenticated
}
