//
//  PhoneticsView.swift
//  WordVault
//
//  Created by Riza Mamedov on 22.12.2024.
//

import SwiftUI
import AVFoundation

struct PhoneticsView: View {
    @State private var audioPlayer: AVPlayer? = nil
    
    @ObservedObject private var audioController: AudioController = .init()
    
    var phonetics: [Phonetic]
    var word: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            Text("Speech records:")
                .font(.title3.weight(.bold))
            ForEach(phonetics, id: \.text) { phonetic in
                VStack(alignment: .leading) {
                    HStack {
                        if let phoneticText = phonetic.text {
                            Text(phoneticText)
                                .font(.headline)
                        } else {
                            Text(word)
                                .font(.headline)
                        }
                    }
                    .padding(.bottom, 2)
                    
                    if let audioUrl = phonetic.audio {
                        HStack {
                            Button(action: {
                                audioController.playAudio(
                                    audioPlayer: &audioPlayer,
                                    url: audioUrl
                                )
                            }) {
                                HStack {
                                    Image(systemName: "play.circle.fill")
                                        .font(.title)
                                        .foregroundColor(.accentColor)
                                    Text("Listen")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.accentColor)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
