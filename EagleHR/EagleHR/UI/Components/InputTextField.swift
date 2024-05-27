//
// Created by Katarina Dokic
//

import Foundation
import SwiftUI

struct InputTextField: View {
    let placeholder: String
    let iconName: String?
    let isSecure: Bool

    @Binding var input: String

    let validationMsg: String?

    init(
        placeholder: String,
        iconName: String? = nil,
        isSecure: Bool = false,
        input: Binding<String>,
        validationMsg: String? = nil
    ) {
        self.placeholder = placeholder
        self.iconName = iconName
        self.isSecure = isSecure
        self._input = input
        self.validationMsg = validationMsg
    }

    var body: some View {
        VStack {
            HStack {
                if isSecure {
                    SecureField(placeholder, text: $input)
                        .textInputAutocapitalization(.never)
                } else {
                    TextField(placeholder, text: $input)
                        .textInputAutocapitalization(.never)
                }
                if let iconName {
                    Image(systemName: iconName)
                        .foregroundStyle(Color(.light))
                }
            }
            .padding(.all, Dimensions.fieldPadding)
            .background {
                RoundedRectangle(cornerRadius: Dimensions.fieldCornerRadius)
                    .fill(.white)
                    .stroke(.light, lineWidth: 2.0)
            }
            if let validationMsg {
                HStack {
                    Text(validationMsg)
                        .font(.caption)
                        .foregroundStyle(Color(.error))
                        .frame(minHeight: 0.0)
                        .padding(.leading, Dimensions.fieldPadding)
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

