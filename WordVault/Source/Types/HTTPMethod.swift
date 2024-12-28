//
//  HTTPMethod.swift
//  WordVault
//
//  Created by Riza Mamedov on 22.12.2024.
//


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    
    func requiresBody() -> Bool {
        switch self {
        case .get, .delete:
            return false
        case .post, .put:
            return true
        }
    }
}
