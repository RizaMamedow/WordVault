//
//  NetworkService.swift
//  WordVault
//
//  Created by Riza Mamedov on 22.12.2024.
//

import Foundation


class NetworkService {
    func sendRequest<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        parameters: [String: Any] = [:],
        headers: [String: String] = [:],
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let requestBuilder: RequestBuilder = RequestBuilder(
            url: url,
            method: method,
            headers: headers,
            parameters: parameters
        )
        let request = requestBuilder.buildRequest()
        
        let responseHandler: ResponseHandler = ResponseHandler<T>(request: request)
        responseHandler.handleResponse(completion: completion)
    }
}
