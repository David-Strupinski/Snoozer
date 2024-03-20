//
//  AlarmEditDetail.swift
//  Snoozer
//
//  Created by David Strupinski on 2/20/24.
//

import SwiftUI

struct AlarmEditDetail: View {
    @Binding var alarms: [Date: Bool]
    var timeIndex: Date
    @State private var time = Date()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Choose an Alarm Time", selection: $time, displayedComponents: .hourAndMinute)
                }
                .onAppear {
                    time = timeIndex
                }
                Button("Submit") {
                    if time != timeIndex {
                        let activeAlarm = alarms[timeIndex]
                        alarms.removeValue(forKey: timeIndex)
                        alarms[time] = activeAlarm
                    }
                    dismiss()
                }
                
                Button("Delete") {
                    alarms.removeValue(forKey: timeIndex)
                    dismiss()
                }
                .foregroundStyle(.red)
            }
        }
        .navigationTitle("Edit Alarm")
    }
}
