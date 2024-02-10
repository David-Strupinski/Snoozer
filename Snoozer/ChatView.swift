//
//  ChatView.swift
//  Snoozer
//
//  Created by David Strupinski on 2/10/24.
//

import Foundation
import SwiftUI

struct ChatView: View {
    var body: some View {
        VStack {
            Text("Friends Chat")
            
            // chat previews (repeat per person)
            VStack {
                HStack {
                    Text("Name")
                    Text("Time")
                }
                
                // last text preview
                Text("last message")
            }
            .border(Color(.black))
        }
    }
}
