//
//  ResponseErrorHandler.swift
//  WordVault
//
//  Created by Riza Mamedov on 27.12.2024.
//

import Foundation

class ResponseErrorHandler<T: Decodable> {
    var error: (any Error)?
    var data: Data?
    var response: URLResponse?
    
    init(error: (any Error)?, data: Data?, response: URLResponse?) {
        self.error = error
        self.data = data
        self.response = response
    }
    
    /// if this function returns true it's means no errors detected and all is correct
    func handleResponseErrors(
        completion: @escaping (Result<T, APIError>) -> Void
    ) -> Bool {
        if self.isResponseNil() {
            if let notFound = self.handleWordNotFoundError(response: self.response!) {
                completion(.failure(notFound))
                return false
            }
        }
        
        
        if let apiError = self.handleTaskError() {
            completion(.failure(apiError))
            return false
        }
        
        guard handleNoDataError() else {
            completion(.failure(.noData))
            return false
        }
        
        return true
    }
    
    private func handleNoDataError() -> Bool {
        return data != nil
    }
    
    private func handleTaskError() -> APIError? {
        guard let error = self.error else { return nil }
        return .requestFailed(error)
    }
    
    private func handleWordNotFoundError(response: URLResponse) -> APIError? {
        if self.getHttpUrlResponse().statusCode == 404 {
            return .wordNotFound
        }
        
        return nil
    }
    
    private func getHttpUrlResponse() -> HTTPURLResponse {
        return self.response as! HTTPURLResponse
    }
    
    private func isResponseNil() -> Bool {
        return self.response != nil
    }
}
