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
    @State private var alarms: [Date: Bool] = [
        stringToTime(str: "7:00 AM"): true,
        stringToTime(str: "8:00 AM"): false,
        stringToTime(str: "10:00 PM"): true
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Alarms")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                // repeat per alarm added
                ForEach(alarms.sorted(by: { $0.key < $1.key }), id: \.key) { (time, active) in
                    NavigationLink(destination: AlarmEditDetail()) {
                        HStack {
                            Toggle(isOn: Binding(
                                get: { alarms[time] ?? false },
                                set: { alarms[time] = $0 }
                            )) {
                                Text(timeToString(time: time))
                            }
                            .toggleStyle(.switch)
                        }
                        .padding()
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                Spacer()
                
                // plus button to add alarms
                NavigationLink(destination: AlarmAddDetail(alarms: $alarms)) {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.black)
                        .background(Color.yellow)
                        .clipShape(Circle())
                        .padding()
                }
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
