//
//  ResponseHandler.swift
//  WordVault
//
//  Created by Riza Mamedov on 22.12.2024.
//

import Foundation

class ResponseHandler<T: Decodable> {
    private var request: URLRequest
    init(request: URLRequest) {
        self.request = request
    }
    
    func handleResponse(
        completion: @escaping (Result<T, APIError>) -> Void
    ) -> Void {
        performTask(completion: completion)
    }
    
    private func performTask(
        completion: @escaping (Result<T, APIError>) -> Void
    ) -> Void {
        URLSession.shared.dataTask(with: request) { data, response, error in
            let errorHandler: ResponseErrorHandler = ResponseErrorHandler<T>(
                error: error,
                data: data,
                response: response
            )
            
            if errorHandler.handleResponseErrors(completion: completion) {
                self.performTaskDataDecoding(from: data!, completion: completion)
            }
        }.resume()
    }
    
    private func performTaskDataDecoding (
        from data: Data,
        completion: @escaping (Result<T, APIError>) -> Void
    ) -> Void {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decodedData))
        } catch {
            completion(.failure(.decodingFailed(error)))
        }
    }
}
