//
//  SearchScreen.swift
//  WordVault
//
//  Created by Riza Mamedov on 23.12.2024.
//



import SwiftUI

struct SearchScreen: View {
    
    @State var wordFieldValue: String = ""
    
    @State var isWordFieldEmpty: Bool = true
    
    var body: some View {
        VStack {
            HStack {
                TextField(
                    "Word",
                    text: $wordFieldValue
                )
                .onChange(of: wordFieldValue) {
                    if (wordFieldValue.isEmpty) {
                        isWordFieldEmpty = true
                    } else {
                        isWordFieldEmpty = false
                    }
                }
                .textFieldStyle(.roundedBorder)
                .disableAutocorrection(true)
                .font(.title2.bold())
                
                NavigationLink(destination: WordDetailScreen(word: wordFieldValue)) {
                    Image(systemName: "magnifyingglass")
                }
                .buttonStyle(.borderedProminent)
                .tint(.accent)
                
            }
            .padding()
        }
    }
}

#Preview {
    SearchScreen()
}


