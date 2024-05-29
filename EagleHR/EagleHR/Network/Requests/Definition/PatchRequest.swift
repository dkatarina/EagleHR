//
// Created by Katarina Dokic
//

import Foundation
import Combine

protocol PatchRequest<RequestBody> : NetworkRequest {
    associatedtype RequestBody: Encodable

    func execute(_ body: RequestBody) -> AnyPublisher<NetworkResponse, Error>
}

extension PatchRequest {
    func execute(_ body: RequestBody) -> AnyPublisher<NetworkResponse, Error> {
        _execute(body)
    }

    func _execute(_ body: RequestBody) -> AnyPublisher<NetworkResponse, Error> {
        do {
            let request = try createRequest(body)
            return execute(request)
        } catch {
            return Fail(error: ApiError(message: genericErrorMsg))
                .eraseToAnyPublisher()
        }
    }

    private func createRequest(_ body: RequestBody) throws -> URLRequest {
        var request = try createRequest(httpMethod: .patch)
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try encoder.encode(body)
        request.httpBody = data
        return request
    }
}
