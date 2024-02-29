//
//  ChatView.swift
//  Snoozer
//
//  Created by David Strupinski on 2/10/24.
//

import Foundation
import SwiftUI

struct ChatView: View {
    @State private var chats: [Chat] = [
        Chat(name: "David"),
        Chat(name: "Nathan"),
        Chat(name: "Amy"),
        Chat(name: "Aaleah")
    ]

    var body: some View {
        NavigationView {
            VStack {
                Text("Chats")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                // chat previews (repeat per person)
                Divider()
                List(chats) { chat in
                    NavigationLink(destination: ChatDetail()) {
                        VStack {
                            HStack {
                                Text(chat.name)
                                
                                Spacer()
                                
                                Text(chat.time)
                            }
                            
                            // last text preview
                            Text(chat.getLastMessage())
                                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .scrollContentBackground(.hidden)
            }
        }
    }
}

class Chat: Identifiable {
    var id = UUID()
    var name: String
    var lastMessage = ""
    var time = ""
    
    init(name: String) {
        self.name = name
    }
    
    func getLastMessage() -> String {
        self.lastMessage = "test"
        self.time = timeToString(time: Date())
        return self.lastMessage
    }
}
