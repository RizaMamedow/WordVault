//
//  NetworkService.swift
//  WordVault
//
//  Created by Riza Mamedov on 22.12.2024.
//

import Foundation


class NetworkService {
    private let requestBuilder: RequestBuilder
    private let responseHandler: ResponseHandler

    init(
        requestBuilder: RequestBuilder = RequestBuilder(),
        responseHandler: ResponseHandler = ResponseHandler()
    ) {
        self.requestBuilder = requestBuilder
        self.responseHandler = responseHandler
    }

    
    private func validateURL(_ endpoint: String) -> URL? {
        guard let url = URL(string: endpoint) else { return nil }
        return url
    }

    func sendRequest<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        responseType: T.Type,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let request = requestBuilder.buildRequest(
            method: method,
            parameters: parameters,
            headers: headers,
            url: url
        )
        
        responseHandler.handleResponse(
            with: request,
            responseType: responseType,
            completion: completion
        )
    }
}
