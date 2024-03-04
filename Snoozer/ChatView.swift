//
//  ChatView.swift
//  Snoozer
//
//  Created by David Strupinski on 2/10/24.
//

import Foundation
import SwiftUI
import UIKit

struct ChatView: View {
    @Binding var friends: [User]
    @State private var chats: [Chat] = []

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
                                Text(chat.user.name)
                                
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
    var user: User
    var lastMessage = ""
    var time = ""
    
    init(user: User) {
        self.user = user
    }
    
    func getLastMessage() -> String {
        self.lastMessage = "test"
        self.time = timeToString(time: Date())
        return self.lastMessage
    }
}

// Managing the chat rows

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        cell.textLabel?.text = messages[indexPath.row]
        return cell
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        if let message = messageTextField.text, !message.isEmpty {
            messages.append(message)
            tableView.reloadData()
            messageTextField.text = ""
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the selected message
        let selectedMessage = messages[indexPath.row]

        // Perform the segue
        performSegue(withIdentifier: "Show segue to View Controller", sender: selectedMessage)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show segue to View Controller" {
//            if let ViewController = segue.destination as? TitleScene {
//                // Pass any data you need to the chat view controller
//                if let message = sender as? String {
//                    ViewController.message = message
//                }
//            }
        }
    }
}

//#Preview {
//    ChatStoryboard()
//}

