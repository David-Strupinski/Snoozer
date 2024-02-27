//
//  VibrationManager.swift
//  Snoozer
//
//  Created by Nathan Ryan Sidik on 2/20/24.
//

import SwiftUI
import AVKit

class SoundManager {
    static let instance = SoundManager() // singleton
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case alarm
        case softalarm
    }
    
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}

struct VibrationManager: View {
    var body: some View {
        VStack(spacing:40) {
            Button("Play Sound 1") {
                SoundManager.instance.playSound(sound: .alarm)
            }
            Button("Play Sound 2") {
                SoundManager.instance.playSound(sound: .softalarm)
            }
        }
    }
}

struct VibrationManager_Previews: PreviewProvider {
    static var previews: some View {
        VibrationManager()
    }
}
