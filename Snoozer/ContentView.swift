//
//  ContentView.swift
//  Snoozer
//
//  Created by David Strupinski on 2/8/24.
//

import SwiftUI
import UIKit
import CoreHaptics

struct ContentView: View {
    @State private var alarms: [Date: Bool] = [:]
    @State private var showAlarmView = false // State to control the presentation of AlarmView
    @Binding var user: User
    @EnvironmentObject var connectionManager: PostgreSQLConnectionManager

    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect() // Timer to check every minute

    var body: some View {
        NavigationView {
            VStack {
                Text("Alarms")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Divider()
                
                if alarms.isEmpty {
                    Spacer()
                    Text("No alarms. Add below")
                        .foregroundStyle(.gray)
                } else {
                    // Repeat per alarm added
                    List(alarms.sorted(by: { $0.key < $1.key }), id: \.key) { time, isActive in
                        NavigationLink(destination: AlarmEditDetail(alarms: $alarms, timeIndex: time)) {
                            HStack {
                                Toggle(isOn: Binding(
                                    get: { alarms[time] ?? false },
                                    set: { newValue in
                                        // Update the state without removing the alarm
                                        alarms[time] = newValue
                                    }
                                )) {
                                    Text(timeToString(time: time))
                                }
                                .toggleStyle(.switch)
                            }
                            .padding(.vertical, 5)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .scrollContentBackground(.hidden)
                }
                
                Spacer()
                
                // Plus button to add alarms
                NavigationLink(destination: AlarmAddDetail(alarms: $alarms)) {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.black)
                        .background(Color.yellow)
                        .clipShape(Circle())
                        .padding(.vertical)
                }
            }
        }
        .onReceive(timer) { _ in
            checkAlarms() // Check alarms every minute
        }
        .sheet(isPresented: $showAlarmView) {
            // Present AlarmView when an alarm is triggered, pass the alarm time
            AlarmView(user: $user, alarmTime: Date())
                .environmentObject(connectionManager)
        }
    }
    
    func checkAlarms() {
        let now = Date()
        for (alarmTime, isActive) in alarms {
            if isActive && Calendar.current.isDate(now, equalTo: alarmTime, toGranularity: .minute) {
                // Trigger the AlarmView when the current time matches an alarm time
                showAlarmView = true
                break // Stop checking once an alarm is triggered
            }
        }
    }
}
    
func stringToTime(str: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh:mm a"
    return dateFormatter.date(from: str)!
}

func timeToString(time: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh:mm a"
    return dateFormatter.string(from: time)
}
