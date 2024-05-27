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
                        .background(
                            Image(uiImage: UIImage(named: "AppIcon")!)
                                .scaleEffect(CGSize(width: 1.0, height: 2.0))
                                .opacity(0.06))
                case .authenticated:
                    AuthenticatedView()
                        .background(
                            Image(uiImage: UIImage(named: "AppIcon")!)
                                .scaleEffect(CGSize(width: 1.0, height: 2.0))
                                .opacity(0.06))
                }
            }
            .onReceive(authenticationManager.isAuthenticated) {
                isAuthenticated = $0
            }
        }
    }
}
