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
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Choose an Alarm Time", selection: $time, displayedComponents: .hourAndMinute)
                }
                
                Section {
                    // TODO: for days of week
                }
                
                Button("Submit") {
                    alarms[time] = true
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .navigationTitle("Add Alarm")
    }
}
