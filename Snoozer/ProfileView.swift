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
                .resizable()
                .frame(width: 200, height: 200)
                .foregroundColor(.gray)
            
            Text("name")
            
            Text("XXX-XXX-XXXX")
            
            Text("Current Streak: ")
            
            Text("Longest Streak: ")
            
            Spacer()
            // Streaks leaderboard
            Text("Friends Leaderboard")
        }
    }
}
