//
//  AddFriendsView.swift
//  Snoozer
//
//  Created by David Strupinski on 3/11/24.
//

import SwiftUI
import PostgresNIO

struct AddFriendsView: View {
    @State private var phone: String = ""
    @FocusState private var numberFocused: Bool
    @Binding var friends: [User]
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var connectionManager: PostgreSQLConnectionManager
    
    var body: some View {
        Text("Add Friend")
            .font(.largeTitle)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
        
        Divider()
        
        Form {
            Section("Phone") {
                TextField("Enter your phone number", text: $phone)
                    .onChange(of: phone) {
                        if !phone.isEmpty {
                            phone = phone.formatPhoneNumber()
                        }
                    }
                    .focused($numberFocused)
                    .onTapGesture {
                        numberFocused = true
                    }
            }
            
            Button("Submit") {
                if !phone.isEmpty {
                    addFriend(phone: phone)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .scrollContentBackground(.hidden)
        
        Spacer()
    }
    
    func addFriend(phone: String) {
        let findFriendSQL = "SELECT * FROM users WHERE phone = '\(phone)' LIMIT 1;"
        do {
            let rows = try connectionManager.connection?.query(findFriendSQL).wait().rows
            if (rows == nil || rows!.isEmpty) {
                print("Cannot find user with phone \(phone)")
            } else {
                let (name, phone, currStreak, longestStreak) = try rows![0].decode((String, String, Int, Int).self)
                friends.append(User(name: name, phone: phone, currStreak: currStreak, longestStreak: longestStreak))
            }
        } catch {
            print("Failed to add friend: \(error.localizedDescription)")
        }
    }
}

