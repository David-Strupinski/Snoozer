//
//  MainView.swift
//  Snoozer
//
//  Created by David Strupinski on 2/18/24.
//

import SwiftUI
import PostgresNIO

struct MainView: View {
    @State private var selection = 2
    @State private var loggedIn = false
    @State private var name = ""
    @State private var phone = ""
    @State var friends: [User] = [
        User(name: "David", phone: "(253) 722-6439"),
        User(name: "Amy", currStreak: 3),
        User(name: "Nathan"),
        User(name: "Aaleah")
    ]
    
    var body: some View {
        if loggedIn {
            TabView(selection: $selection) {
                ProfileView(name: $name, phone: $phone, friends: $friends)
                    .tabItem {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
                    .tag(1)
                
                ContentView()
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
            AddProfileView(name: $name, phone: $phone, loggedIn: $loggedIn)
        }
    }
}

struct User: Identifiable {
    var id = UUID()
    var name: String
    var phone: String?
    var currStreak = 0
    var longestStreak = 0
}

extension User {
    var currStreakString: String {
        String(currStreak)
    }
    var longestStreakString: String {
        String(longestStreak)
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

#Preview {
    MainView()
}
