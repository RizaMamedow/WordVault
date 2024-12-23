//
//  ResponseHandler.swift
//  WordVault
//
//  Created by Riza Mamedov on 22.12.2024.
//

import Foundation

class ResponseHandler {
    private func handleTaskError(_ error: (any Error)?) -> APIError? {
        guard let error = error else { return nil }
        return .requestFailed(error)
    }
    
    private func handleWordNotFoundError(
        response: URLResponse?
    ) -> APIError? {
        guard let httpResponse = response as? HTTPURLResponse else {
            return .noData
        }
        
        if httpResponse.statusCode == 404 {
            return .wordNotFound
        }
        
        return nil
    }

    private func handleTaskDataDecoding<T: Decodable>(
        _ responseType: T.Type,
        from data: Data,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decodedData))
        } catch {
            completion(.failure(.decodingFailed(error)))
        }
    }

    private func handleTask<T: Decodable>(
        with request: URLRequest,
        responseType: T.Type,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
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
            
            self.handleTaskDataDecoding(responseType, from: data, completion: completion)
        }.resume()
    }
    
    func handleResponse<T: Decodable>(
        with request: URLRequest,
        responseType: T.Type,
        completion: @escaping (Result<T, APIError>) -> Void
    ) -> Void {
        handleTask(
            with: request,
            responseType: responseType,
            completion: completion
        )
    }
}
