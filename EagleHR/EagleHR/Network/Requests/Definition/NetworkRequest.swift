//
// Created by Katarina Dokic
//

import Foundation
import Combine

protocol NetworkRequest<NetworkResponse> {
    associatedtype NetworkResponse: Decodable

    var url: String { get }
}

protocol Authorized {}

extension NetworkRequest {
    var baseURL: URL? {
        return URL(string: url)
    }

    internal var genericErrorMsg: String {
        "Something went wrong. Please try again."
    }

    internal func createRequest(httpMethod: HttpMethod) throws -> URLRequest  {
        if let baseURL {
            var request = URLRequest(url: baseURL)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if (self is Authorized) {
                if let authToken = AuthenticationManager.shared.getAuthToken() {
                    request.setValue("Basic \(authToken)", forHTTPHeaderField: "Authorization")
                } else {
                    throw ApiError(code: 401, message: "User is not logged in")
                }
            }
            request.httpMethod = httpMethod.rawValue
            return request
        } else {
            throw ApiError()
        }
    }

    internal func execute(_ request: URLRequest) -> AnyPublisher<NetworkResponse, Error> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap(httpErrorToFailure)
            .decode(type: NetworkResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }

    private func httpErrorToFailure(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        let statusCode = (output.response as! HTTPURLResponse).statusCode
        if (400..<600).contains(statusCode) {
            let errorMsg: String
            do {
                errorMsg = try JSONDecoder().decode(ApiErrorBody.self, from: output.data).message
            } catch {
                errorMsg = genericErrorMsg
            }
            throw ApiError(code: statusCode, message: errorMsg)
        }
        return output.data
    }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
}
