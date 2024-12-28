//
//  RequestParameterHandler.swift
//  WordVault
//
//  Created by Riza Mamedov on 28.12.2024.
//

import Foundation

class RequestParameterHandler {
    private var parameters: [String: Any]
    private var method: HTTPMethod
    private var request: URLRequest
    
    init(parameters: [String : Any] = [:], method: HTTPMethod, request: URLRequest) {
        self.parameters = parameters
        self.method = method
        self.request = request
    }
    
    func prepareParameters() -> Void {
        if self.checkMethodRequiresBody() {
            self.encodeRequestBody()
            self.setContentTypeToJSON()
        }
    }
    
    private func checkMethodRequiresBody() -> Bool {
        return self.method.requiresBody()
    }

    private func encodeRequestBody() -> Void {
        self.request.httpBody = try? JSONSerialization.data(withJSONObject: self.parameters)
    }

    private func setContentTypeToJSON() -> Void {
        self.request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}
