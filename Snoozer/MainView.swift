//
//  MainView.swift
//  Snoozer
//
//  Created by David Strupinski on 2/18/24.
//

import SwiftUI
import PostgresNIO
import Logging
import Combine
import StreamChat
import StreamChatSwiftUI

struct MainView: View {
    @State private var selection = 2
    @State private var loggedIn = false
    @State private var user = User(name: "", phone: "")
    // TODO: add way to add friends by phone
    @State var friends: [User] = [
        User(name: "David", phone: "(253) 722-6439"),
        User(name: "Amy", phone: "", currStreak: 3),
        User(name: "Nathan", phone: ""),
        User(name: "Aaleah", phone: "")
    ]
    @EnvironmentObject var connectionManager: PostgreSQLConnectionManager
    
    //@StateObject private var channelListViewModel = ChatChannelListViewModel() // Initialize your view model
    
    var body: some View {
        if loggedIn {
            TabView(selection: $selection) {
                ProfileView(user: $user, friends: $friends)
                    .tabItem {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
                    .tag(1)
                    .environmentObject(connectionManager)
                
                // Alarm list view
                ContentView(user: $user)
                    .tabItem {
                        Label("Alarms", systemImage: "alarm")
                    }
                    .tag(2)
                    .environmentObject(connectionManager)
                
//                VStack {
//                    CustomChannelList(channelListController: channelListViewModel.channelListController)
//                        .navigationTitle("Channel List")
//
//                    CustomChannelList(channelId: "chatChannel")
//                        .navigationTitle("Channel")
//                }
            
                // ChatUIView tab
//                ChatUIView()
//                    .tabItem {
//                    Label("Chat", systemImage: "ellipsis.message")
//                    }
//                    .tag(3)
//                    .environmentObject(connectionManager)
                                
                // CustomChannelList tab
//                let channelId = ChannelId(type: "messaging", id: "general")
//                CustomChannelList(channelId: channelId)
//                    .tabItem {
//                    Label("Custom Channel List", systemImage: "list.bullet")
//                    }
//                    .tag(3)
//                    .environmentObject(connectionManager)
                
                ChatView(friends: $friends)
                    .tabItem {
                        Label("Chat", systemImage: "ellipsis.message")
                    }
                    .tag(3)
                    .environmentObject(connectionManager)
            }
        } else {
            // force users to make profile
            AddProfileView(user: $user, loggedIn: $loggedIn)
                .environmentObject(connectionManager)
        }
    }
}

struct User: Identifiable {
    var id = UUID()
    var name: String
    var phone: String
    var currStreak = 0
    var longestStreak = 0
}

extension String {
    func formatPhoneNumber() -> String {
        let cleanNumber = components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        let mask = "(XXX) XXX-XXXX"
        
        var result = ""
        var startIndex = cleanNumber.startIndex
        let endIndex = cleanNumber.endIndex
        
        for char in mask where startIndex < endIndex {
            if char == "X" {
                result.append(cleanNumber[startIndex])
                startIndex = cleanNumber.index(after: startIndex)
            } else {
                result.append(char)
            }
        }
        
        return result
    }
}
