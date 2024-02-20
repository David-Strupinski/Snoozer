//
//  VibrationManager.swift
//  Snoozer
//
//  Created by Nathan Ryan Sidik on 2/20/24.
//

import AudioToolbox

class VibrationManager {
    
    static let shared = VibrationManager() // Singleton instance
    
    private init() {} // Private initializer to ensure singleton usage
    
    func vibrate() {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    // Custom pattern vibration (iOS 13 and later)
    // duration: time in seconds; intensity: 0 (min) to 1 (max)
    @available(iOS 13.0, *)
    func vibrateWithPattern(duration: Double, intensity: Float) {
        let vibrationPattern: [NSNumber] = [0, NSNumber(value: duration)]
        let intensityPattern: [NSNumber] = [NSNumber(value: intensity)]
        
//        var dictionary = [String: Any]()
//        dictionary[kCustomVibrationPatternKey] = vibrationPattern
//        dictionary[kVibrationIntensityKey] = intensityPattern
//        
//        AudioServicesStopSystemSound(SystemSoundID(kSystemSoundID_Vibrate))
//        AudioServicesPlaySystemSoundWithVibration(SystemSoundID(kSystemSoundID_Vibrate), nil, dictionary)
    }
}
