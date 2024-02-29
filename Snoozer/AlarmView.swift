//
//  AlarmView.swift
//  Snoozer
//
//  Created by David Strupinski on 2/10/24.
//

import Foundation
import SwiftUI

struct AlarmView: View {
    @State private var isAlarmOn = true
    
    var body: some View {
        VStack {
            Text("7:00")
                .font(.system(size: 100))
            
            Image(systemName: "alarm")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Button(action: {
                // Stop the sound and haptic feedback when the button is tapped
                SoundManager.instance.player?.stop()
                print("Alarm Stopped")
            }) {
                Text("Stop Alarm")
                    .font(.system(size: 40))
                    .padding(.horizontal, 50)
                    .padding(.vertical, 10)
                    .background(Color.orange)
                    .foregroundColor(.black)
                    .clipShape(Capsule())
            }
            .padding(50)
            
            Button(action: {
                print("You Snooze You Lose")
            }) {
                Text("Snoozer")
                    .font(.system(size: 20))
                    .padding(.horizontal, 25)
                    .padding(.vertical, 10)
                    .background(Color.orange)
                    .foregroundColor(.black)
                    .clipShape(Capsule())
            }
            .padding(.bottom, 10)
        
            HStack (spacing: 0) {
                Spacer()
                
                Text("3")
                Image(systemName: "flame.fill")
                    .padding(.trailing, 10.0)
                
                Text("ENDS STREAK")
                
                Spacer()
            }
            .padding(.bottom, 50)
        }
        .onAppear {
            // Play the alarm sound and trigger haptic feedback as soon as the view appears
            SoundManager.instance.playSound(sound: .alarm)
            // Trigger haptic feedback
            HapticManager.instance.notification(type: .success)
            GyroscopeManager.shared.startMonitoring()
            GyroscopeManager.shared.isUpright = { upright in
                if upright {
                    // Stop the Alarm if the phone is upright
                    self.stopAlarm()
                }
            }
        }
        .onDisappear {
            GyroscopeManager.shared.stopMonitoring() // Stop monitoring when the view disappears
        }
    }
    
    func stopAlarm() {
        isAlarmOn = false
        SoundManager.instance.player?.stop() // Stops the alarm sound
        GyroscopeManager.shared.stopMonitoring() // Stops gyroscope mechanism
    }

}

// Preview
// struct AlarmView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlarmView()
//    }
//}
