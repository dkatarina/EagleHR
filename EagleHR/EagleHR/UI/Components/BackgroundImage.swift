//
// Created by Katarina Dokic
//

import Foundation
import SwiftUI

struct BackgroundImage : View {
    let opacity: CGFloat

    var body: some View {
        Image(uiImage: UIImage(named: "AppIcon")!)
            .scaleEffect(CGSize(width: 1.8, height: 1.5))
            .opacity(opacity)
    }
}

#Preview {
    BackgroundImage(opacity: 0.2)
}
