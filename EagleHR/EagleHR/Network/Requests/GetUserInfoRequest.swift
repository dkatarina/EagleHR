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

    private let authenticationManager = AuthenticationManager.shared

    func execute() -> AnyPublisher<Response, Error> {
        _execute()
            .handleEvents(receiveOutput: storeAvailablePto)
            .eraseToAnyPublisher()
    }

    private func storeAvailablePto(response: GetUserInfoRequest.NetworkResponse) {
        authenticationManager.saveAvailablePto(response.pto)
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

        let pto: Int

        enum CodingKeys: String, CodingKey {
            case firstName
            case lastName
            case dateOfBirth = "dob"
            case hireDate

            case email
            case address
            case phoneNumber
            case college = "degree"

            case pto
        }
    }
}
