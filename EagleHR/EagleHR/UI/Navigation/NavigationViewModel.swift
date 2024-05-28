//
// Created by Katarina Dokic
//

import Foundation

extension NavigationView {
    @Observable
    class ViewModel {
        var selectedTab = tabs[0]
        var isLogoutDialogShown = false

        private let authenticationManager = AuthenticationManager.shared

        static let tabs = ["My Info", "Used Days", "Organization"]

        func logout() {
            do {
                try authenticationManager.removeAuthToken()
            } catch {
                assertionFailure("Failed to logout")
            }
        }
    }
}
