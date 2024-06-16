//
//  SoundManager.swift
//  Practica_RealityKit_AGGA
//
//  Created by Alejandro Gavira on 16/6/24.
//

import AVFoundation

final class SoundManager {
    static let shared = SoundManager()
    private var player: AVAudioPlayer?
    
    func playSound(_ name:String,_ intensity: Float? = nil,_ repeating: Bool? = true) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            NSLog("Sound not found")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = repeating ?? true ? -1 : 1
            player?.play()
            if let intensity = intensity {
                player?.volume = intensity
            }
        } catch {
            print("Failed SoundManager > PlaySound")
        }
    }
    
    func stopSound() {
        player?.stop()
    }
    
}
