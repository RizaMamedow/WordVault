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
    
    public func buildRequest() -> URLRequest {
        setMethodToRequest()
        prepareHeaders()
        prepareParameters()
        
        return request
    }

    private func prepareHeaders() -> Void {
        for (key, value) in self.headers {
            self.request.addValue(value, forHTTPHeaderField: key)
        }
    }

    private func prepareParameters() -> Void {
        if (self.methodRequiresBody(for: self.method)) {
            self.encodeRequestBody()
            self.setContentTypeToJSON()
        }
    }
    
    private func methodRequiresBody(for method: HTTPMethod) -> Bool {
        return self.method == .post || self.method == .put
    }

    private func encodeRequestBody() -> Void{
        self.request.httpBody = try? JSONSerialization.data(withJSONObject: self.parameters)
    }

    private func setContentTypeToJSON() -> Void {
        self.request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
    
    private func setMethodToRequest() -> Void {
        self.request.httpMethod = self.method.rawValue
    }
}
