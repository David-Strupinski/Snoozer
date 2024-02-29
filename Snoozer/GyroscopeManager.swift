//
//  GyroscopeManager.swift
//  Snoozer
//
//  Created by Nathan Ryan Sidik on 2/29/24.
//

import CoreMotion
import Foundation

class GyroscopeManager {
    static let shared = GyroscopeManager() // Singleton instance

    private var motionManager: CMMotionManager
    var isUpright: ((Bool) -> Void)? // Closure to handle upright detection
    
    private init() {
        motionManager = CMMotionManager()
    }
    
    func startMonitoring() {
        guard motionManager.isGyroAvailable else {
            print("Gyroscope is not available on this device.")
            return
        }
        
        motionManager.gyroUpdateInterval = 0.1 // Update every 0.1 seconds
        
        motionManager.startGyroUpdates(to: .main) { [weak self] (gyroData, error) in
            guard let data = gyroData else {
                if let error = error {
                    print("Gyroscope monitoring error: \(error.localizedDescription)")
                }
                return
            }

            // Check if the device is upright by examining the z-axis rotation rate
            // Adjust the threshold according to your needs for what 'upright' means
            let zRotationRate = data.rotationRate.z
            let isUpright = abs(zRotationRate) < 0.5 // Example threshold for 'upright'
            
            // Call the closure with the result
            self?.isUpright?(isUpright)
        }
    }
    
    func stopMonitoring() {
        motionManager.stopGyroUpdates() // Stop the gyroscope updates
    }
}
