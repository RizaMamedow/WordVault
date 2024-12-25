//
//  RequestBuilder.swift
//  WordVault
//
//  Created by Riza Mamedov on 22.12.2024.
//

import Foundation


class RequestBuilder {
    private var request: URLRequest
    var method: HTTPMethod
    var headers: [String: String]
    var parameters: [String: Any]
    
    init(
        url: URL,
        method: HTTPMethod,
        headers: [String: String] = [:],
        parameters: [String: Any] = [:]
    ) {
        self.request = URLRequest(url: url)
        self.method = method
        self.headers = headers
        self.parameters = parameters
    }
    
    func buildRequest() -> URLRequest {
        setMethod()
        handleHeaders()
        handleParameters()
        
        return request
    }
    

    private func handleHeaders() -> Void {
        for (key, value) in self.headers {
            self.request.addValue(value, forHTTPHeaderField: key)
        }
    }

    private func handleParameters() -> Void {
        guard self.supportsBody(for: method) else { return }
        self.setRequestBody()
        self.addContentTypeHeader()
    }
    
    private func supportsBody(for method: HTTPMethod) -> Bool {
        return self.method == .post || self.method == .put
    }

    private func setRequestBody() -> Void{
        self.request.httpBody = try? JSONSerialization.data(withJSONObject: self.parameters)
    }

    private func addContentTypeHeader() -> Void {
        self.request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    private func setMethod() -> Void {
        self.request.httpMethod = self.method.rawValue
    }
}
