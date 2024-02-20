//
//  MainView.swift
//  Snoozer
//
//  Created by David Strupinski on 2/18/24.
//

import SwiftUI

struct MainView: View {
    @State private var selection = 2
    
    var body: some View {
        TabView(selection: $selection) {
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
                .tag(1)
            
            ContentView()
                .tabItem {
                    Label("Alarms", systemImage: "alarm")
                }
                .tag(2)
            
            ChatView()
                .tabItem {
                    Label("Chat", systemImage: "ellipsis.message")
                }
                .tag(3)
        }
    }
}

struct User {
    var name: String
    var phone: String
    var curStreak: Int
    var longestStreak: Int
}

#Preview {
    MainView()
}
