//
//  RequestBuilder.swift
//  WordVault
//
//  Created by Riza Mamedov on 22.12.2024.
//

import Foundation


class RequestBuilder {
    private var request: URLRequest
    private var parameterHandler: RequestParameterHandler
    private var headers: [String: String]
    private var method: HTTPMethod
    
    init(
        url: URL,
        method: HTTPMethod,
        headers: [String: String] = [:],
        parameters: [String: Any] = [:]
    ) {
        self.request = URLRequest(url: url)
        self.headers = headers
        self.method = method
        self.parameterHandler = RequestParameterHandler.init(
            parameters: parameters,
            method: method,
            request: self.request
        )
    }
    
    public func buildRequest() -> URLRequest {
        setMethodToRequest()
        prepareHeaders()
        parameterHandler.prepareParameters()
        
        return request
    }

    private func prepareHeaders() -> Void {
        for (key, value) in self.headers {
            self.request.addValue(value, forHTTPHeaderField: key)
        }
    }
    
    private func setMethodToRequest() -> Void {
        self.request.httpMethod = self.method.rawValue
    }
}
