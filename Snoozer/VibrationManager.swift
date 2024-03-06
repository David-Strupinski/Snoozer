//
//  VibrationManager.swift
//  Snoozer
//
//  Created by Nathan Ryan Sidik on 2/20/24.
//

import SwiftUI
import AVKit

// SoundManager: A singleton class responsible for managing sound playback
class SoundManager {
    static let instance = SoundManager() // Singleton instance
    
    var player: AVAudioPlayer?
    
    // Enum to represent different sound options
    enum SoundOption: String {
        case alarm
        case softalarm
    }
    
    // Function to play a specified sound
    func playSound(sound: SoundOption) {
        // Get the URL for the sound file
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            // Create an AVAudioPlayer instance with the sound URL
            player = try AVAudioPlayer(contentsOf: url)
            player?.play() // Play the sound
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}

// VibrationManager: A view for testing sound playback
struct VibrationManager: View {
    var body: some View {
        VStack(spacing: 40) {
            // Button to play Sound 1 (alarm)
            Button("Play Sound 1") {
                SoundManager.instance.playSound(sound: .alarm)
            }
            // Button to play Sound 2 (softalarm)
            Button("Play Sound 2") {
                SoundManager.instance.playSound(sound: .softalarm)
            }
        }
    }
}

// Preview Provider
struct VibrationManager_Previews: PreviewProvider {
    static var previews: some View {
        VibrationManager()
    }
}
