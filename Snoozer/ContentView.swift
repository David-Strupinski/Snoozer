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
    // TODO: convert to [Date: [Weekday: Bool]] dict for per day control
    @State private var alarms: [Date: Bool] = [:]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Alarms")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                // repeat per alarm added
                if alarms.isEmpty {
                    Spacer()
                    
                    Text("No alarms. Add below")
                        .foregroundStyle(.gray)
                } else {
                    List(alarms.sorted(by: { $0.key < $1.key }), id: \.key) { (time, active) in
                        NavigationLink(destination: AlarmEditDetail(alarms: $alarms, timeIndex: time)) {
                            HStack {
                                Toggle(isOn: Binding(
                                    get: { alarms[time] ?? false },
                                    set: { alarms[time] = $0 }
                                )) {
                                    Text(timeToString(time: time))
                                }
                                .toggleStyle(.switch)
                            }
                            .padding(.vertical, 5)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .background(.white)
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
                        .padding(.vertical)
                }
            }
        }
    }
}

enum Weekday: Int, CaseIterable {
    case sunday = 0, monday, tuesday, wednesday, thursday, friday, saturday
    
    var name: String {
        switch self {
        case .sunday: return "Sunday"
        case .monday: return "Monday"
        case .tuesday: return "Tuesday"
        case .wednesday: return "Wednesday"
        case .thursday: return "Thursday"
        case .friday: return "Friday"
        case .saturday: return "Saturday"
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
