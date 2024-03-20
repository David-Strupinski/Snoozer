//
//  AlarmAddDetail.swift
//  Snoozer
//
//  Created by David Strupinski on 2/20/24.
//

import SwiftUI

struct AlarmAddDetail: View {
    @State private var time = Date()
    @Binding var alarms: [Date: Bool]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Choose an Alarm Time", selection: $time, displayedComponents: .hourAndMinute)
                }
                
                Button("Submit") {
                    alarms[time] = true
                    dismiss()
                }
            }
        }
        .navigationTitle("Add Alarm")
    }
}
