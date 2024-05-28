//
// Created by Katarina Dokic
//

import Foundation
import SwiftUI

struct InputTextField: View {
    let placeholder: String
    let iconName: String?
    let isSecure: Bool
    let isEnabled: Bool

    @Binding var input: String

    let validationMsg: String?

    var color: Color {
        isEnabled ? .light : .gray
    }

    init(
        placeholder: String = "",
        iconName: String? = nil,
        isSecure: Bool = false,
        input: Binding<String>,
        validationMsg: String? = nil,
        isEnabled: Bool = true
    ) {
        self.placeholder = placeholder
        self.iconName = iconName
        self.isSecure = isSecure
        self._input = input
        self.validationMsg = validationMsg
        self.isEnabled = isEnabled
    }

    var body: some View {
        VStack(spacing: 0.0) {
            HStack {
                if isSecure {
                    SecureField(placeholder, text: $input)
                        .textInputAutocapitalization(.never)
                        .disabled(!isEnabled)
                } else {
                    TextField(placeholder, text: $input)
                        .textInputAutocapitalization(.never)
                        .disabled(!isEnabled)
                }
                if let iconName {
                    Image(systemName: iconName)
                        .foregroundStyle(color)
                }
            }
            .padding(.all, Dimensions.fieldPadding)
            .background {
                RoundedRectangle(cornerRadius: Dimensions.fieldCornerRadius)
                    .fill(.white)
                    .stroke(color, lineWidth: 2.0)
            }
            if let validationMsg {
                HStack {
                    Text(validationMsg)
                        .font(.caption)
                        .foregroundStyle(Color(.error))
                        .frame(minHeight: 0.0)
                        .padding(.leading, Dimensions.fieldPadding)
                        .padding(.top, 5.0)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    struct Preview: View {
        @State var input: String = ""

        var body: some View {
            InputTextField(
                placeholder: "Email",
                iconName: "envelope.fill",
                input: $input,
                validationMsg: "Invalid email"
            )
        }
    }
    return Preview()
}

