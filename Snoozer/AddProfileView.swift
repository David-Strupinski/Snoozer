//
//  AddProfileView.swift
//  Snoozer
//
//  Created by David Strupinski on 2/29/24.
//

import SwiftUI
import PostgresNIO

struct AddProfileView: View {
    @Binding var name: String
    @Binding var phone: String
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
                TextField("Enter your name", text: $name)
                    .focused($nameFocused)
                    .onTapGesture {
                        nameFocused = true
                    }
            }
            
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
                if !name.isEmpty {
                    addProfile(connectionManager: connectionManager, name: name, phone: phone)
                    
                    loggedIn = true
                    _ = MainView()
                }
            }
        }
        .scrollContentBackground(.hidden)
        
        Spacer()
    }
}

func addProfile(connectionManager: PostgreSQLConnectionManager, name: String, phone: String) {
    let addProfileSQL = "INSERT INTO users VALUES ('\(name)', '\(phone)');"
    do {
        _ = try connectionManager.connection?.query(addProfileSQL).wait()
    } catch {
        print("Failed to add profile: \(error.localizedDescription)")
    }
}
