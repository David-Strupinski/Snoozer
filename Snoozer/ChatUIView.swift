//
//  ChatUIView.swift
//  Snoozer
//
//  Created by Amy Cheng on 3/11/24.
//

import SwiftUI
import StreamChat
import StreamChatSwiftUI

struct ChatUIView: App {
    var chatClient: ChatClient = {
            var config = ChatClientConfig(apiKey: .init("8br4watad788"))
            config.isLocalStorageEnabled = true
            config.applicationGroupIdentifier = "group.io.getstream.iOS.ChatDemoAppSwiftUI"

            // The resulting config is passed into a new `ChatClient` instance.
            let client = ChatClient(config: config)
            return client
        }()
    
//    var colors = ColorPalette()
//    let streamBlue = UIColor(red: 0, green: 108.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
//    colors.messageCurrentUserBackground = [streamBlue]
//    colors.messageCurrentUserTextColor = .white
    
    let images = Images()
    //images.reactionLoveBig = UIImage(systemName: "")!
        
        @State var streamChat: StreamChat?
        
        init() {
            streamChat = StreamChat(chatClient: chatClient)
            connectUser()
        }
        
        var body: some Scene {
            WindowGroup {
//                ChatChannelListView()
               //CustomChannelList(channelId: ChannelId)
            }
        }
        
        private func connectUser() {
            // This is a hardcoded token valid on Stream's tutorial environment.
            let token = try! Token(rawValue: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoibHVrZV9za3l3YWxrZXIifQ.kFSLHRB5X62t0Zlc7nwczWUfsQMwfkpylC6jCUZ6Mc0")
            
            // Call `connectUser` on our SDK to get started.
            chatClient.connectUser(
                userInfo: .init(
                    id: "luke_skywalker",
                    name: "Luke Skywalker",
                    imageURL: URL(string: "https://vignette.wikia.nocookie.net/starwars/images/2/20/LukeTLJ.jpg")!
                ),
                token: token
            ) { error in
                if let error = error {
                    // Some very basic error handling only logging the error.
                    log.error("connecting the user failed \(error)")
                    return
                }
            }
        }
}
