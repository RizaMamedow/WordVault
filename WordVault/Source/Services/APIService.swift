//
//  APIService.swift
//  WordVault
//
//  Created by Riza Mamedov on 21.12.2024.
//
import Foundation


final class APIService: NetworkService {
    private let httpService: NetworkService

    init(httpService: NetworkService = NetworkService()) {
        self.httpService = httpService
    }
    
    static let shared = APIService() // Singleton

    private func getDynamicEndpoint(word: String) -> String {
        return "\(Config.API_URL)/\(word)"
    }

    func fetchWordData(
        word: String,
        completion: @escaping (Result<[DictionaryAPIModel], APIError>) -> Void
    ) {
        httpService.sendRequest(
            endpoint: getDynamicEndpoint(word: word),
            method: .get,
            completion: completion
        )
    }
}
