//
// Created by Katarina Dokic
//

import Foundation

struct ApiError: Error {
    let code: Int?
    let message: String?

    init(code: Int? = nil, message: String? = nil) {
        self.code = code
        self.message = message
    }
}

struct ApiErrorBody: Decodable {
    let message: String
}
