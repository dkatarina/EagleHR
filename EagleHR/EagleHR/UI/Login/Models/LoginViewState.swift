//
// Created by Katarina Dokic
//

import Foundation

extension LoginView {
    struct ViewState {
        var loginResult: ProcessingResult? = nil {
            didSet {
                isErrorDialogShown = if case .failure(_) = loginResult {
                    true
                } else {
                    false
                }
            }
        }

        var email = Input(
            placeholder: "Email",
            iconName: "envelope.fill",
            validator: InputValidator(
                regexPattern: "[\\w\\-\\.]+@([\\w\\-]+\\.)+[\\w\\-]{2,4}",
                invalidMsg: "Invalid email"
            )
        )

        var password = Input(
            placeholder: "Password",
            iconName: "key.fill",
            validator: InputValidator(
                regexPattern: ".{8,}",
                invalidMsg: "Minimum password length is 8"
            )
        )

        var isLoginEnabled: Bool {
            return email.isValid && password.isValid && !isProgressViewShown
        }

        var isProgressViewShown: Bool {
            if case .processing = loginResult {
                true
            } else {
                false
            }
        }

        var isErrorDialogShown: Bool = false
        var error: DescriptiveError? {
            if case .failure(let error) = loginResult {
                error
            } else {
                nil
            }
        }
    }
}
