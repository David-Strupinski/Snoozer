//
//  AddProfileView.swift
//  Snoozer
//
//  Created by David Strupinski on 2/29/24.
//

import SwiftUI
import PostgresNIO

struct AddProfileView: View {
    @Binding var user: User
    @Binding var loggedIn: Bool
    @Environment(\.presentationMode) var presentationMode
    @FocusState private var nameFocused: Bool
    @FocusState private var numberFocused: Bool
    @EnvironmentObject var connectionManager: PostgreSQLConnectionManager
    
    var body: some View {
        Text("Create Your Profile")
            .font(.largeTitle)
            .fontWeight(.bold)
        
        Divider()
        
        Form {
            Section("Name") {
                TextField("Enter your name", text: $user.name)
                    .focused($nameFocused)
                    .onTapGesture {
                        nameFocused = true
                    }
            }
            
            Section("Phone") {
                TextField("Enter your phone number", text: $user.phone)
                    .onChange(of: user.phone) {
                        if !user.phone.isEmpty {
                            user.phone = user.phone.formatPhoneNumber()
                        }
                    }
                    .focused($numberFocused)
                    .onTapGesture {
                        numberFocused = true
                    }
            }
            
            Button("Submit") {
                if (!user.name.isEmpty && !user.phone.isEmpty) {
                    addProfile(user: user)
                    
                    loggedIn = true
                    _ = MainView()
                }
            }
        }
        .scrollContentBackground(.hidden)
        
        Spacer()
    }
    
    func addProfile(user: User) {
        let addProfileSQL = "INSERT INTO users VALUES ('\(user.name)', '\(user.phone)', 0, 0);"
        do {
            _ = try connectionManager.connection?.query(addProfileSQL).wait()
        } catch {
            print("Failed to add profile: \(error.localizedDescription)")
        }
    }
}
