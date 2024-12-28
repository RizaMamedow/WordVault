//
//  NetworkService.swift
//  WordVault
//
//  Created by Riza Mamedov on 22.12.2024.
//

import Foundation


class NetworkService {
    static let shared = NetworkService()
    
    func sendRequest<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        parameters: [String: Any] = [:],
        headers: [String: String] = [:],
        completion: @escaping (Result<T, APIError>) -> Void
    ) -> Void {
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let request = self.prepareRequest(
            url: url,
            method: method,
            parameters: parameters,
            headers: headers
        )
        
        let responseHandler: ResponseHandler = ResponseHandler<T>(request: request)
        responseHandler.handleResponse(completion: completion)
    }
    
    private func prepareRequest(
        url: URL,
        method: HTTPMethod = .get,
        parameters: [String: Any] = [:],
        headers: [String: String] = [:]
    ) -> URLRequest {
        let requestBuilder: RequestBuilder = RequestBuilder(
            url: url,
            method: method,
            headers: headers,
            parameters: parameters
        )
        
        return requestBuilder.buildRequest()
    }
}
