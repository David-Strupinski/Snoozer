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
    
    func playSound() {
        guard let url = URL(string: "") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
        
        
    }
}
//
//struct VibrationManager: View {
//    var soundManager = SoundManager()
//    
//}
