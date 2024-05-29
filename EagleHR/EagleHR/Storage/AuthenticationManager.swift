//
// Created by Katarina Dokic
//

import Foundation
import Combine

struct AuthenticationManager {
    static let shared = AuthenticationManager()

    private let keychainManager = KeychainManager.shared
    private let defaults = UserDefaults.standard

    private enum Keys {
        static let authorizationTokenKey = "authorizationToken"
        static let userIdKey = "userId"
        static let availablePtoKey = "availablePto"

        static let authorizedDefaultsKeys = [userIdKey, availablePtoKey]
    }

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
        keychainManager.remove(key: Keys.authorizationTokenKey)
        isAuthenticated.send(.notAuthenticated)
    }

    private func removeAuthDefaults() {
        Keys.authorizedDefaultsKeys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }

    func saveAuthToken(_ token: String) {
        if (!keychainManager.store(token, key: Keys.authorizationTokenKey)) {
            assertionFailure("Failed to save authorization token")
        }
        DispatchQueue.main.async {
            isAuthenticated.send(.authenticated)
        }
    }

    func logout() {
        removeAuthDefaults()
        removeAuthToken()
    }

    func getAuthToken() -> String? {
        keychainManager.get(key: Keys.authorizationTokenKey)
    }

    func saveUserId(_ userId: Int) {
        defaults.set(userId, forKey: Keys.userIdKey)
    }

    func saveAvailablePto(_ pto: Int) {
        defaults.set(pto, forKey: Keys.availablePtoKey)
    }

    func getAvailablePto() -> Int {
        defaults.integer(forKey: Keys.availablePtoKey)
    }

    func getUserId() -> Int {
        defaults.integer(forKey: Keys.userIdKey)
    }
}

enum IsAuthenticated {
    case checking
    case notAuthenticated
    case authenticated
}
