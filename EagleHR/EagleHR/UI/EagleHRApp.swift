//
//  Created Katarina Dokic
//

import SwiftUI

@main
struct EagleHRApp: App {
    let authenticationManager = AuthenticationManager.shared
    @State var isAuthenticated: IsAuthenticated = .checking

    var body: some Scene {
        WindowGroup {
            Group {
                switch(isAuthenticated) {
                case .checking:
                    SplashScreen()
                case .notAuthenticated:
                    LoginView()
                case .authenticated:
                    NavigationView()
                }
            }
            .onReceive(authenticationManager.isAuthenticated) {
                isAuthenticated = $0
            }
        }
    }
}
