//
// Created by Katarina Dokic
//

import Foundation
import SwiftUI

struct OverlayProgressView: View {
    var body: some View {
        ZStack {
            ProgressView()
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(Color(.dark).opacity(0.1))
    }
}

#Preview {
    OverlayProgressView()
}
