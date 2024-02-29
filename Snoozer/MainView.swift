//
//  MainView.swift
//  Snoozer
//
//  Created by David Strupinski on 2/18/24.
//

import SwiftUI

struct MainView: View {
    @State private var selection = 2
    @State private var loggedIn = false
    @State private var name = ""
    @State private var phone = ""
    
    var body: some View {
        if loggedIn {
            TabView(selection: $selection) {
                ProfileView(name: $name, phone: $phone)
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
        } else {
            AddProfileView(name: $name, phone: $phone, loggedIn: $loggedIn)
        }
    }
}

struct User {
    var name: String
    var phone: String
    var curStreak: Int
    var longestStreak: Int
}

extension String {
    func formatPhoneNumber() -> String {
        let cleanNumber = components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        let mask = "(XXX) XXX-XXXX"
        
        var result = ""
        var startIndex = cleanNumber.startIndex
        var endIndex = cleanNumber.endIndex
        
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
