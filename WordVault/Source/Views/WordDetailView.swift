//
//  WordDetailView.swift
//  WordVault
//
//  Created by Riza Mamedov on 22.12.2024.
//

import SwiftUI


struct WordDetailView: View {
    let wordData: DictionaryAPIModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(wordData.word.capitalized)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                if let phonetic = wordData.phonetic {
                    Text("Phonetic: \(phonetic)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                if (!wordData.phonetics.isEmpty) {
                    PhoneticsView(
                        phonetics: wordData.phonetics,
                        word: wordData.word
                    )
                }
                if (!wordData.meanings.isEmpty){
                    MeaningsView(meanings: wordData.meanings)
                }
                
                LicenseView(license: wordData.license, sourceUrls: wordData.sourceUrls)
            }
            .padding(.horizontal)
        }
        .navigationTitle("Word details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
