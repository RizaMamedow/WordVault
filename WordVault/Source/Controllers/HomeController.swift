//
//  HomeController.swift
//  WordVault
//
//  Created by Riza Mamedov on 21.12.2024.
//

import Foundation


class HomeController: ObservableObject {
    @Published var shuffledWordArray: [String] = []
    
    func getRandomWord() -> String {
        return Store.popularWords.randomElement()!
    }
    
    func shuffleWords(limit: Int = 300) -> Void {
        shuffledWordArray = Array(Store.popularWords.shuffled().prefix(limit))
    }
    
    func refreshScreen() -> Void { shuffleWords(limit: 100) }
}
