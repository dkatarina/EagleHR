//
// Created by Katarina Dokic
//

import Foundation
import SwiftUI

extension LoginView {
    struct Input {
        var content: String = ""
        {
            didSet {
                if content.isEmpty {
                    isValid = false
                    validationMsg = ""
                    return
                }
                switch validator.validate(content) {
                case .valid:
                    isValid = true
                    validationMsg = ""
                case .invalid(let validationMsg):
                    isValid = false
                    self.validationMsg = validationMsg
                }
            }
        }
        let placeholder: String
        let iconName: String

        var isValid: Bool = false
        var validationMsg: String = ""

        private let validator: InputValidator

        init(placeholder: String, iconName: String, validator: InputValidator) {
            self.placeholder = placeholder
            self.iconName = iconName
            self.validator = validator
        }
    }
}
