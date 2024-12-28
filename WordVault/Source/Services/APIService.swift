//
//  APIService.swift
//  WordVault
//
//  Created by Riza Mamedov on 21.12.2024.
//
import Foundation


final class APIService {
    static let shared = APIService()

    private func generateEndpoint(word: String) -> String {
        return "\(Config.API_URL)/\(word)"
    }

    func fetchWordData(
        word: String,
        completion: @escaping (Result<[DictionaryAPIModel], APIError>) -> Void
    ) {
        NetworkService.shared.sendRequest(
            endpoint: generateEndpoint(word: word),
            method: .get,
            completion: completion
        )
    }
}
