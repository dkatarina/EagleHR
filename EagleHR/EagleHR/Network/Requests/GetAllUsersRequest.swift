//
// Created by Katarina Dokic
//

import Foundation

struct GetAllUsersRequest : GetRequest, Authorized {
    typealias NetworkResponse = Response

    var url: String {
        "https://api-assigment.eaglelab.com/v1/users"
    }
}

extension GetAllUsersRequest {
    struct Response : Decodable {
        let items: [User]
    }

    struct User : Decodable {
        let id: Int
        let firstName: String
        let lastName: String
        let hireDate: String
        let email: String
        let phoneNumber: String
        let dateOfBirth: String

        enum CodingKeys: String, CodingKey {
            case id
            case firstName
            case lastName
            case hireDate
            case email
            case phoneNumber
            case dateOfBirth = "dob"
        }
    }
}
