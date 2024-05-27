//
// Created by Katarina Dokic
//

import Foundation
import SwiftUI

struct RoundButton : View {
    let title: String
    let isEnabled: Bool

    let action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(title)
                .frame(
                    minWidth: Dimensions.minButtonWidth,
                    minHeight: Dimensions.minButtonHeight
                )
                .foregroundStyle(Color(.white))
                .font(.headline)
                .bold()
        })
        .disabled(!isEnabled)
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(ButtonBorderShape.roundedRectangle(radius: Dimensions.buttonCornerRadius))
        .presentationCornerRadius(Dimensions.buttonCornerRadius)
        .shadow(radius: Dimensions.buttonShadowRadius)
        .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    RoundButton(
        title: "OK",
        isEnabled: true,
        action: {}
    )
}
