//
//  WordDetailScreen.swift
//  WordVault
//
//  Created by Riza Mamedov on 21.12.2024.
//

import SwiftUI

struct WordDetailScreen: View {
    @StateObject var controller: WordDetailsController = .init()
    @State var word: String
    
    var body: some View {
        VStack {
            if !controller.isLoading {
                WordDetailView(wordData: controller.wordData!)
            } else if controller.errorMessage != nil {
                ErrorScreen(errorMessage: controller.errorMessage!)
            } else {
                LoadingScreen()
            }
        }
        .refreshable {
            controller.loadWordData(word: word)
        }
        .onAppear{
            controller.loadWordData(word: word)
        }
    }
}

#Preview {
    WordDetailScreen(word: "hello")
}

