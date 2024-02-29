//
//  AddProfileView.swift
//  Snoozer
//
//  Created by David Strupinski on 2/29/24.
//

import SwiftUI

struct AddProfileView: View {
    @Binding var name: String
    @Binding var phone: String
    @Binding var loggedIn: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Text("Create Your Profile")
            .font(.largeTitle)
            .fontWeight(.bold)
        
        Divider()
        
        Form {
            Section("Name") {
                TextField("Enter your name", text: $name)
            }
            
            Section("Phone") {
                TextField("Enter your phone number", text: $phone)
                    .onChange(of: phone) {
                        if !phone.isEmpty {
                            phone = phone.formatPhoneNumber()
                        }
                    }
            }
            
            Button("Submit") {
                loggedIn = true
                MainView()
            }
        }
        .scrollContentBackground(.hidden)
        
        Spacer()
    }
}
