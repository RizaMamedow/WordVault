//
//  APIError.swift
//  WordVault
//
//  Created by Riza Mamedov on 22.12.2024.
//

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case noData
    case decodingFailed(Error)
    case wordNotFound
}

extension APIError {
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .requestFailed(let error):
            return "Request failed with error: \(error.localizedDescription)"
        case .wordNotFound:
            return "No Definitions Found"
        case .noData:
            return "No data received from the server."
        case .decodingFailed(let error):
            return "Failed to decode the response: \(error.localizedDescription)"
        }
    }
}
