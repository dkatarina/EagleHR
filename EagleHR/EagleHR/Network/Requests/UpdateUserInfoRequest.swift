//
// Created by Katarina Dokic
//

import Foundation

import Combine

struct UpdateUserInfoRequest : PatchRequest, Authorized {
    typealias NetworkResponse = Response
    typealias RequestBody = Body

    private let authenticationManager = AuthenticationManager.shared

    var url: String {
        let userId = authenticationManager.getUserId()
        return "https://api-assigment.eaglelab.com/v1/users/\(userId)"
    }
}

extension UpdateUserInfoRequest {
    struct Body : Encodable {
        let email: String
        let address: String
        let phoneNumber: String
        let college: String

        enum CodingKeys: String, CodingKey {
            case email
            case address
            case phoneNumber
            case college = "degree"
        }
    }

    struct Response : Decodable {}
}
