//
// Created by Katarina Dokic
//

import Foundation
import Combine

struct LoginRequest : PostRequest {
    typealias NetworkResponse = Response
    typealias RequestBody = Body

    var url: String {
        "https://api-assigment.eaglelab.com/v1/login"
    }

    private let authenticationManager = AuthenticationManager.shared

    func execute(body: Body) -> AnyPublisher<Response, Error> {
        _execute(body)
            .handleEvents(receiveOutput: storeAuthData)
            .mapError { failure in
                let code = (failure as? ApiError)?.code
                return if code == 401 {
                    ApiError(code: code, message: "Wrong login credentials.")
                } else {
                    failure
                }
            }.eraseToAnyPublisher()
    }

    private func storeAuthData(loginResponse: NetworkResponse) {
        authenticationManager.saveAuthToken(loginResponse.token)
        authenticationManager.saveUserId(loginResponse.userId)
    }
}

extension LoginRequest {
    struct Body : Codable {
        let email: String
        let password: String
    }

    struct Response : Decodable {
        let token: String
        let userId: Int

        enum CodingKeys : String, CodingKey {
            case token
            case userId = "id"
        }
    }
}
