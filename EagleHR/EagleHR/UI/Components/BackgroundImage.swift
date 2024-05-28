//
// Created by Katarina Dokic
//

import Foundation
import SwiftUI

struct BackgroundImage : View {
    let opacity: CGFloat

    var body: some View {
        Image(uiImage: UIImage(named: "AppIcon")!)
            .scaleEffect(CGSize(width: 1.2, height: 2.1))
            .opacity(opacity)
    }
}
