//
//  MeaningsView.swift
//  WordVault
//
//  Created by Riza Mamedov on 22.12.2024.
//

import SwiftUI

struct MeaningsView: View {
    var meanings: [Meaning]
    
    var body: some View {
        VStack {
            ForEach(meanings, id: \.partOfSpeech) { meaning in
                VStack(alignment: .leading, spacing: 10) {
                    Text(meaning.partOfSpeech.capitalized)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.accentColor)
                    
                    ForEach(meaning.definitions, id: \.definition) { definition in
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Definition: \(definition.definition)")
                                .font(.body)
                                .foregroundColor(.primary)
                            
                            if let example = definition.example {
                                Text("Example: \(example)")
                                    .font(.body)
                                    .italic()
                                    .foregroundColor(.secondary)
                            }
                            
                            if !definition.synonyms.isEmpty {
                                Text("Synonyms: \(definition.synonyms.joined(separator: ", "))")
                                    .font(.body)
                                    .foregroundColor(.blue)
                            }
                            
                            if !definition.antonyms.isEmpty {
                                Text("Antonyms: \(definition.antonyms.joined(separator: ", "))")
                                    .font(.body)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
