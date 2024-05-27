//
// Created by Katarina Dokic
//

import Foundation
import SwiftUI

struct AnimatedImage: View {
    @State private var image: Image?
    private let nextImageNames: [String]

    init(startingImageName: String, nextImageNames: [String]) {
        self.image = Image(startingImageName)
        self.nextImageNames = nextImageNames
    }

    var body: some View {
        Group {
            image?
                .resizable()
                .scaledToFit()
        }.onAppear(perform: {
            self.animate()
        })
    }

    private func animate() {
        var imageIndex: Int = 0

        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if imageIndex < self.nextImageNames.count {
                self.image = Image(self.nextImageNames[imageIndex])
                imageIndex += 1
            }
            else {
                timer.invalidate()
            }
        }
    }
}

#Preview {
    AnimatedImage(
        startingImageName: "SplashIcon1",
        nextImageNames: ["SplashIcon2", "SplashIcon3", "SplashIcon4"]
    )
}
