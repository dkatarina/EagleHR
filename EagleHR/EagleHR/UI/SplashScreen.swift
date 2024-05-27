//
// Created by Katarina Dokic
//

import Foundation
import SwiftUI

struct SplashScreen : View {
    var body: some View {
        ZStack {
            AnimatedImage(
                startingImageName: "SplashIcon1",
                nextImageNames: ["SplashIcon2", "SplashIcon3", "SplashIcon4"]
            )
            .frame(
                width: Dimensions.splashScreenIconSize,
                height: Dimensions.splashScreenIconSize
            )
        }
    }
}

#Preview {
    SplashScreen()
}
