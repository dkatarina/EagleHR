//
// Created by Katarina Dokic
//

import Foundation
import Combine

protocol PostRequest<RequestBody> : NetworkRequest {
    associatedtype RequestBody: Encodable

    func execute(body: RequestBody?) -> AnyPublisher<NetworkResponse, Error>
}

extension PostRequest {
    func execute(body: RequestBody? = nil) -> AnyPublisher<NetworkResponse, Error> {
        _execute(body)
    }

    internal func _execute(_ body: RequestBody?) -> AnyPublisher<NetworkResponse, Error> {
        do {
            let request = try createRequest(body)
            return execute(request)
        } catch {
            return Fail(error: ApiError(message: genericErrorMsg))
                .eraseToAnyPublisher()
        }
    }

    private func createRequest(_ body: RequestBody?) throws -> URLRequest {
        var request = try createRequest()
        request.httpMethod = "POST"
        if let body {
            let encoder = JSONEncoder()
            let data = try encoder.encode(body)
            request.httpBody = data
        }
        return request
    }
}
