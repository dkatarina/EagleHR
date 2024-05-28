//
// Created by Katarina Dokic
//

import Foundation
import Combine

struct GetUserInfoRequest : GetRequest, Authorized {
    typealias NetworkResponse = Response

    var url: String {
        "https://api-assigment.eaglelab.com/v1/users/profile"
    }
}

extension GetUserInfoRequest {
    struct Response : Decodable {
        let firstName: String
        let lastName: String
        let dateOfBirth: String
        let hireDate: String

        let email: String
        let address: String
        let phoneNumber: String
        let college: String

        enum CodingKeys: String, CodingKey {
            case firstName
            case lastName
            case dateOfBirth = "dob"
            case hireDate

            case email
            case address
            case phoneNumber
            case college = "degree"
        }
    }
}
