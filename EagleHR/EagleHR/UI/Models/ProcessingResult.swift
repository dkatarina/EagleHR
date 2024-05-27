//
// Created by Katarina Dokic
//

import Foundation

enum ProcessingResult {
    case success
    case failure(_ error: DescriptiveError)
    case processing
}

struct DescriptiveError: LocalizedError {
    var errorDescription: String?
}
