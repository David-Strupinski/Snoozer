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
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        // list of friends to add chats
        List(friends) { friend in
            Button(friend.name) {
                chats.append(Chat(user: friend))
                dismiss()
            }
        }
    }
}
