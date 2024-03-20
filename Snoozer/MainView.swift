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

@Observable class User: Identifiable {
    var id = UUID()
    var name: String
    var phone: String
    
    private var _longestStreak = 0
    var currStreak = 0 {
        didSet {
            _longestStreak = max(_longestStreak, currStreak)
            updateStreak()
        }
    }
    var longestStreak: Int {
        _longestStreak
    }
    
    init(name: String, phone: String, currStreak: Int = 0, longestStreak: Int = 0) {
        self.name = name
        self.phone = phone
        self.currStreak = currStreak
        self._longestStreak = longestStreak
    }
    
    private func updateStreak() {
        // this is SAFE in postgres-nio
        let updateStreakSQL = """
            UPDATE users SET currStreak = \(self.currStreak), longestStreak = \(self.longestStreak) WHERE phone = '\(self.phone)';
        """
        
        do {
            _ = try connectionManager.connection?.query(updateStreakSQL).wait()
        } catch {
            print("Failed to increment user streak")
        }
    }
}

struct MainView: View {
    @State private var selection = 2
    @State private var loggedIn = false
    @State private var user = User(name: "", phone: "")
    @State var friends: [User] = [  // TODO: eventually remove test friends
        User(name: "David", phone: "(253) 722-6439"),
        User(name: "Amy", phone: "", currStreak: 3),
        User(name: "Nathan", phone: ""),
        User(name: "Aaleah", phone: "")
    ]
    
    var body: some View {
        if loggedIn {
            TabView(selection: $selection) {
                ProfileView(user: $user, friends: $friends)
                    .tabItem {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
                    .tag(1)
                
                // Alarm list view
                ContentView(user: $user)
                    .tabItem {
                        Label("Alarms", systemImage: "alarm")
                    }
                    .tag(2)
                
                ChatView(friends: $friends)
                    .tabItem {
                        Label("Chat", systemImage: "ellipsis.message")
                    }
                    .tag(3)
            }
        } else {
            // force users to make profile
            AddProfileView(user: $user, loggedIn: $loggedIn)
        }
    }
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
