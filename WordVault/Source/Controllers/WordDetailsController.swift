//
//  WordDetailsController.swift
//  WordVault
//
//  Created by Riza Mamedov on 21.12.2024.
//
import Foundation

class WordDetailsController: ObservableObject {
    @Published var _wordData: [DictionaryAPIModel] = []
    @Published var errorMessage: String?

    var wordData: DictionaryAPIModel? {
        return _wordData.first ?? nil
    }
    
    var isLoading: Bool {
        return wordData == nil
    }
    
    var isError: Bool {
        return errorMessage != nil
    }
    
    func loadWordData(word: String) {
        APIService.shared.fetchWordData(word: word) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?._wordData = data
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
