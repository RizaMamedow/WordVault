//
//  WordDetailScreen.swift
//  WordVault
//
//  Created by Riza Mamedov on 21.12.2024.
//

import SwiftUI

struct WordDetailScreen: View {
    @ObservedObject var controller: WordDetailsController = .init()
    @State var word: String
    
    init(word: String) {
        self.word = word
    }
    
    var body: some View {
        contentView
            .onAppear() {
                controller.loadWordData(word: word)
            }
    }
    
    private var contentView: some View {
        VStack {
            if let wordData = controller.wordData {
                WordDetailView(wordData: wordData)
            } else if let errorMessage = controller.errorMessage {
                ErrorScreen(errorMessage: errorMessage)
            } else {
                LoadingScreen()
            }
        }
    }
}

#Preview {
    WordDetailScreen(word: "hello")
}

