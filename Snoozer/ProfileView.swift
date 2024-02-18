//
//  ProfileView.swift
//  Snoozer
//
//  Created by David Strupinski on 2/10/24.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
            
            Text("name")
            
            Text("XXX-XXX-XXXX")
            
            Spacer()
            
            // streaks leaderboard
            Text("Current Streak: ")
            
            Text("Longest Streak: ")
            
            Spacer()
        }
    }
}
