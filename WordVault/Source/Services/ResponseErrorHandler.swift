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
    func checkResponseErrors(
        completion: @escaping (Result<T, APIError>) -> Void
    ) -> Bool {
        if let response = self.response {
            if let notFound = self.checkWordNotFoundError(response: response) {
                completion(.failure(notFound))
                return false
            }
        }
        
        if let apiError = self.checkTaskError() {
            return giveNoDataError(completion: completion)
        }
        
        guard data != nil else {
            
            return false
        }
        
        return true
    }
    
    private func checkTaskError() -> APIError? {
        guard let error = self.error else { return nil }
        return .requestFailed(error)
    }
    
    
    private func checkWordNotFoundError(response: URLResponse) -> APIError? {
        if self.getHttpUrlResponse().statusCode == 404 {
            return .wordNotFound
        }
        
        return nil
    }
    
    private func giveNoDataError(
        completion: @escaping (Result<T, APIError>) -> Void
    ) -> Bool {
        completion(.failure(.noData))
        return false
    }
    
    private func getHttpUrlResponse() -> HTTPURLResponse {
        return self.response as! HTTPURLResponse
    }
}
