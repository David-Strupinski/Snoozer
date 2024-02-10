//
//  AlarmView.swift
//  Snoozer
//
//  Created by David Strupinski on 2/10/24.
//

import Foundation
import SwiftUI

struct AlarmView: View {
    @State private var alarmOn = false
    
    
    var body: some View {
        VStack {
            Text("Alarm")
            
            // repeat per alarm added
            HStack {
                Toggle(isOn: $alarmOn) {
                    Text("7:00 AM")
                }
                .toggleStyle(.switch)
            }
        }
    }
}
