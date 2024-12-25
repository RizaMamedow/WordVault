//
//  APIService.swift
//  WordVault
//
//  Created by Riza Mamedov on 21.12.2024.
//
import Foundation


final class APIService: NetworkService {
    private let httpService: NetworkService

    private let apiUrl = "https://api.dictionaryapi.dev/api/v2/entries/en"
    
    private var defaultEndpoint: String {
        return "\(self.apiUrl)/hello"
    }

    
    private init(httpService: NetworkService = NetworkService()) {
        self.httpService = httpService
    }
    
    private func getDynamicEndpoint(word: String) -> String {
        return "\(apiUrl)/\(word)"
    }

    static let shared = APIService() // Singleton

    func fetchWordData(
        word: String,
        completion: @escaping (Result<[DictionaryAPIModel], APIError>) -> Void
    ) {
        httpService.sendRequest(
            endpoint: getDynamicEndpoint(word: word),
            method: .get,
            responseType: [DictionaryAPIModel].self,
            completion: completion
        )
    }
}
