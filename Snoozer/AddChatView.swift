//
//  AddChatView.swift
//  Snoozer
//
//  Created by David Strupinski on 3/4/24.
//

import SwiftUI

struct AddChatView: View {
    @Binding var chats: [Chat]
    @Binding var friends: [User]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        List(friends) { friend in
            Button(friend.name) {
                chats.append(Chat(user: friend))
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
