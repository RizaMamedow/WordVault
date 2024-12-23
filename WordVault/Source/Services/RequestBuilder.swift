//
//  RequestBuilder.swift
//  WordVault
//
//  Created by Riza Mamedov on 22.12.2024.
//

import Foundation


class RequestBuilder {
    private func setMethod(method: HTTPMethod, request: inout URLRequest) {
        request.httpMethod = method.rawValue
    }

    private func addHeaders(_ headers: [String: String], request: inout URLRequest) {
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
    }

    private func handleHeaders(_ headers: [String: String]?, request: inout URLRequest) {
        guard let headers = headers else { return }
        addHeaders(headers, request: &request)
    }

    private func supportsBody(for method: HTTPMethod) -> Bool {
        return method == .post || method == .put
    }

    private func setRequestBody(_ parameters: [String: Any], for request: inout URLRequest) {
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
    }

    private func addContentTypeHeader(to request: inout URLRequest) {
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }

    private func handleParameters(
        _ parameters: [String: Any]?,
        method: HTTPMethod,
        request: inout URLRequest
    ) {
        guard let parameters = parameters, supportsBody(for: method) else { return }
        setRequestBody(parameters, for: &request)
        addContentTypeHeader(to: &request)
    }
    
    
    func buildRequest(
        method: HTTPMethod,
        parameters: [String: Any]?,
        headers: [String: String]?,
        url: URL
    ) -> URLRequest {
        var request = URLRequest(url: url)
        
        setMethod(method: method, request: &request)
        handleHeaders(headers, request: &request)
        handleParameters(parameters, method: method, request: &request)
        
        return request
    }
}
