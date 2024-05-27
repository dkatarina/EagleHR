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

    func execute(body: Body?) -> AnyPublisher<Response, Error> {
        _execute(body)
            .handleEvents(receiveOutput: storeAuthToken)
            .mapError { failure in
                let code = (failure as? ApiError)?.code
                return if code == 401 {
                    ApiError(code: code, message: "Wrong login credentials.")
                } else {
                    failure
                }
            }.eraseToAnyPublisher()
    }

    private func storeAuthToken(loginResponse: NetworkResponse) {
        if let token = loginResponse.token {
            authenticationManager.saveAuthToken(token)
        }
    }
}

extension LoginRequest {
    struct Body : Codable {
        let email: String
        let password: String
    }

    struct Response : Decodable {
        let token: String?
        let message: String?
    }
}
