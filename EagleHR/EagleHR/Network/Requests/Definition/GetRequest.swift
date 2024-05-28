//
// Created by Katarina Dokic
//

import Foundation
import Combine

protocol GetRequest : NetworkRequest {
    func execute() -> AnyPublisher<NetworkResponse, Error>
}

extension GetRequest {
    func execute() -> AnyPublisher<NetworkResponse, Error> {
        do {
            let request = try createRequest(httpMethod: .get)
            return execute(request)
        } catch {
            return Fail(error: ApiError(message: genericErrorMsg))
                .eraseToAnyPublisher()
        }
    }
}
