//
//  AudioController.swift
//  WordVault
//
//  Created by Riza Mamedov on 23.12.2024.
//

import Foundation
import AVFoundation

class AudioController: ObservableObject {
    func playAudio(audioPlayer: inout AVPlayer?, url: String) {
        guard let audioUrl = URL(string: url) else { return }
        
        if audioPlayer != nil {
            audioPlayer?.pause()
        }
        
        audioPlayer = AVPlayer(url: audioUrl)
        audioPlayer?.play()
    }
}
