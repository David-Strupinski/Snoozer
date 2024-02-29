//
//  ProfileView.swift
//  Snoozer
//
//  Created by David Strupinski on 2/10/24.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @Binding var name: String
    @Binding var phone: String
    @State private var currStreak = 0
    @State private var longestStreak = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 200, height: 200)
                .foregroundColor(.gray)
            
            Text(name)
            
            Text(phone)
            
            Text("Current Streak: " + currStreak.formatted())
            
            Text("Longest Streak: " + longestStreak.formatted())
            
            Spacer()
            // Streaks leaderboard
            Text("Friends Leaderboard")
        }
    }
}
