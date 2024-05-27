//
// Created by Katarina Dokic
//

import Foundation
import SwiftUI

extension View {
    func hidden(_ isHidden: Bool) -> some View {
        return self.opacity(isHidden ? 0.0 : 1.0)
    }
}
