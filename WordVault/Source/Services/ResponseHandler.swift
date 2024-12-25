//
//  ResponseHandler.swift
//  WordVault
//
//  Created by Riza Mamedov on 22.12.2024.
//

import Foundation

class ResponseHandler<T: Decodable> {
    var request: URLRequest
    
    init(request: URLRequest) {
        self.request = request
    }
    
    func handleResponse(
        completion: @escaping (Result<T, APIError>) -> Void
    ) -> Void {
        handleTask(completion: completion)
    }
    
    private func handleTask(
        completion: @escaping (Result<T, APIError>) -> Void
    ) -> Void {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let apiError = self.handleTaskError(error) {
                completion(.failure(apiError))
                return
            }
            
            if let notFound = self.handleWordNotFoundError(response: response) {
                completion(.failure(notFound))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            self.performTaskDataDecoding(from: data, completion: completion)
        }.resume()
    }
    
    private func handleTaskError(_ error: (any Error)?) -> APIError? {
        guard let error = error else { return nil }
        return .requestFailed(error)
    }
    
    private func handleWordNotFoundError(response: URLResponse?) -> APIError? {
        guard let httpResponse = self.getHTTPUrlResponse(response) else {
            return .noData
        }
        
        if httpResponse.statusCode == 404 {
            return .wordNotFound
        }
        
        return nil
    }
    
    private func getHTTPUrlResponse(_ response: URLResponse?) -> HTTPURLResponse? {
        return response as? HTTPURLResponse
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
