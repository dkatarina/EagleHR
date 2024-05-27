//
// Created by Katarina Dokic
//

import Foundation

enum ValidationResult {
    case valid
    case invalid(_ validationMsg: String)
}

struct InputValidator {
    var regexPattern: String
    var invalidMsg: String

    func validate(_ input: String) -> ValidationResult {
        do {
            return try if input.isEmpty || Regex(regexPattern).regex.wholeMatch(in: input) != nil {
                .valid
            } else {
                .invalid(invalidMsg)
            }
        } catch let error {
            assertionFailure(error.localizedDescription)
            return .invalid(invalidMsg)
        }
    }
}
