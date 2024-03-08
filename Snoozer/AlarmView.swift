//
//  AlarmView.swift
//  Snoozer
//
//  Created by David Strupinski on 2/10/24.
//

import SwiftUI

struct AlarmView: View {
    @State private var isAlarmOn = true
    @State private var showTriviaView = false // State variable to control navigation to TriviaView
    @Binding var user: User
    @EnvironmentObject var connectionManager: PostgreSQLConnectionManager
    
    let alarmTime: Date // Alarm time received from ContentView
    
    var body: some View {
        NavigationView { // Embedding AlarmView in NavigationView
            VStack {
                // Display the time received from ContentView
                Text(timeToString(time: alarmTime))
                    .font(.system(size: 60))
                
                // Image representing the alarm
                Image(systemName: "alarm")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                NavigationLink(destination: TriviaView(), isActive: $showTriviaView) { // NavigationLink to TriviaView
                    EmptyView() // Hidden NavigationLink
                }
                
                Button(action: {
                    // Stop the sound and haptic feedback when the button is tapped
                    stopAlarm()
                    print("Alarm Stopped")
                    incrementStreak()
                    showTriviaView = true // Activate navigation to TriviaView
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
                    resetStreak()
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
    }
    
    func stopAlarm() {
        isAlarmOn = false
        SoundManager.instance.player?.stop() // Stops the alarm sound
        GyroscopeManager.shared.stopMonitoring() // Stops gyroscope mechanism
    }

    func resetStreak() {
        let phone = self.user.phone
        let resetStreakSQL = "UPDATE users SET currStreak = 0 WHERE phone = '\(phone)';"
        do {
            _ = try connectionManager.connection?.query(resetStreakSQL).wait()
        } catch {
            print("Failed to reset user streak: \(error.localizedDescription)")
        }
    }
    
    func incrementStreak() {
        self.user.currStreak += 1
        if self.user.currStreak > self.user.longestStreak {
            self.user.longestStreak = self.user.currStreak
        }
        let incrementStreakSQL = "UPDATE users SET currStreak = \(self.user.currStreak), longestStreak = \(self.user.longestStreak) WHERE phone = '\(self.user.phone)';"
        
        do {
            _ = try connectionManager.connection?.query(incrementStreakSQL).wait()
        } catch {
            print("Failed to increment user streak")
        }
    }
}
