//
//  ContentView.swift
//  Snoozer
//
//  Created by David Strupinski on 2/8/24.
//

import SwiftUI
import UIKit
import CoreHaptics

struct ContentView: View {
    var body: some View {
        VStack {
            Text("7:00")
                .font(.system(size: 100))
            
            Image(systemName: "alarm")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Button(action: {
                print("You Snooze You Lose")
            }) {
                Text("Snoozer")
                    .font(.system(size: 40))
                    .padding(.horizontal, 50)
                    .background(Color.orange)
                    .foregroundColor(.black)
                    .clipShape(Capsule())
            }
            .padding(50)
            
            Spacer()
            
            GroupBox(label: Label("Home", systemImage: "plus")) {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Content")/*@END_MENU_TOKEN@*/
            }
        }
    }
}

#Preview {
    ContentView()
}
