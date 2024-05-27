//
// Created by Katarina Dokic
//

import Foundation
import Combine

protocol NetworkRequest<NetworkResponse> {
    associatedtype NetworkResponse: Decodable

    var url: String { get }
}

extension NetworkRequest {
    var baseURL: URL? {
        return URL(string: url)
    }

    internal var genericErrorMsg: String {
        "Something went wrong. Please try again"
    }

    internal func createRequest() throws -> URLRequest  {
        if let baseURL {
            var request = URLRequest(url: baseURL)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return request
        } else {
            throw ApiError()
        }
    }

    internal func execute(_ request: URLRequest) -> AnyPublisher<NetworkResponse, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap(httpErrorToFailure)
            .decode(type: NetworkResponse.self, decoder: JSONDecoder())
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
