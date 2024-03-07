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
                
                Divider()
                
                // add new chats button
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: AddChatView(chats: $chats, friends: $friends)) {
                        Image(systemName: "square.and.pencil")
                            .imageScale(.large)
                    }
                    .padding()
                }
                
                // chat previews (repeat per person)
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
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func getLastMessage() -> String {
        self.lastMessage = "test"
        self.time = timeToString(time: Date())
        return self.lastMessage
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupViews()
//    }
//    
//    private func setupViews() {
//        // Title
//        let messageLabel = UILabel()
//        messageLabel.text = "Messages"
//        messageLabel.textAlignment = .center
//        messageLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(messageLabel)
//        
//        // Position the label
//        NSLayoutConstraint.activate([
//            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
}

// Managing the chat rows for ChatStoryboard

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // adjust measurements of profile circle
        let largeSize = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large)
        let image = UIImage(systemName: "person.crop.circle", withConfiguration: largeSize)
        
        // change label name to friend's name
//        Friend.text = "David"
        return 5
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    
    func tableRow(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        cell.textLabel?.text = messages[indexPath.row]
        return cell
        
    }
    
    func heightTable(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Return the  height for table cell at indexPath
        return 500
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        if let message = messageTextField.text, !message.isEmpty {
            messages.append(message)
            tableView.reloadData()
            messageTextField.text = ""
        }
    }
    
    func nextPage(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the selected message
        let selectedMessage = messages[indexPath.row]
        
        // Perform the segue
        performSegue(withIdentifier: "ShowChat", sender: selectedMessage)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChat" {
            if let AllChat = segue.destination as? PrivateChat {
                if let message = sender as? String {
                    //PrivateChat.message = message
                }
            }
        }
    }
    
    class PrivateChat: UIViewController {
        
        func showMessage() {
            print("You're going to be late for class!")
        }
        
        func sendMessage(message: String) -> Bool {
            print("\(message)")
            
            return !message.isEmpty
        }
    }
}
