//
//  ProfileView.swift
//  Snoozer
//
//  Created by David Strupinski on 2/10/24.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @Binding var user: User
    @Binding var friends: [User]
    
    var body: some View {
        VStack {
            Text("Profile")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Divider()
            
            Spacer()
            
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 200, height: 200)
                .foregroundColor(.gray)
            
            Text(user.name)
            
            Text(user.phone)
            
            Text("Current Streak: \(user.currStreak)")
            
            Text("Longest Streak: \(user.longestStreak)")
            
            Spacer()
            
            // Streaks leaderboard
            List {
                HStack {
                    Text("Friends Leaderboard")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .frame(width: 325, alignment: .center)
                }
                HStack {
                    Text("Name")
                    Spacer()
                    Text("Current Streak")
                    Spacer()
                    Text("Longest Streak")
                }
                .frame(width: 325, alignment: .center)
                ForEach(friends) { friend in
                    HStack {
                        Text(friend.name)
                            .frame(width: 125, alignment: .leading)
                        Text("\(friend.currStreak)")
                            .frame(width: 100, alignment: .center)
                        Text("\(friend.longestStreak)")
                            .frame(width: 100, alignment: .trailing)
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}
