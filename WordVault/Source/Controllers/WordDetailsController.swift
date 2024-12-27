//
//  WordDetailsController.swift
//  WordVault
//
//  Created by Riza Mamedov on 21.12.2024.
//
import Foundation

class WordDetailsController: ObservableObject {
    @Published private var _wordData: [DictionaryAPIModel] = []
    @Published var errorMessage: String?

    var wordData: DictionaryAPIModel? {
        return self.getWordData()
    }
    
    var isLoading: Bool {
        return wordData == nil
    }
    
    var isError: Bool {
        return errorMessage != nil
    }
    
    private func getWordData() -> DictionaryAPIModel? {
        return _wordData.first ?? nil
    }
    
    private func setWordData(_ data: [DictionaryAPIModel]) -> Void {
        self._wordData = data
    }
    
    private func setErrorMessage(_ message: String) -> Void {
        self.errorMessage = message
    }
    
    func loadWordData(word: String) {
        APIService.shared.fetchWordData(word: word) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.setWordData(data)
                case .failure(let error):
                    self?.setErrorMessage(error.localizedDescription)
                }
            }
        }
    }
}
