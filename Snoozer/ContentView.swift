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
                print("Alarm Stopped")
            }) {
                Text("Stop Alarm")
                    .font(.system(size: 40))
                    .padding(.horizontal, 50)
                    .padding(.vertical, 10)
                    .background(Color.orange)
                    .foregroundColor(.black)
                    .clipShape(Capsule())
            }
            .padding(50)
            
            Button(action: {
                print("You Snooze You Lose")
            }) {
                Text("Snoozer")
                    .font(.system(size: 20))
                    .padding(.horizontal, 25)
                    .padding(.vertical, 10)
                    .background(Color.orange)
                    .foregroundColor(.black)
                    .clipShape(Capsule())
            }
            .padding(.bottom, 10)
            
            HStack (spacing: 0) {
                Spacer()
                
                Text("3")
                Image(systemName: "flame.fill")
                    .padding(.trailing, 10.0)
                
                Text("ENDS STREAK")
                
                Spacer()
            }
            .padding(.bottom, 50)
            
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button(action: {
                    print("hi")
                }) {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
                .padding(.vertical, 10)
                
                Spacer()
                
                Button(action: {
                    print("hi")
                }) {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                }
                .padding(.bottom, 20)
                
                Spacer()
                
                Button(action: {
                    print("hi")
                }) {
                    Image(systemName: "ellipsis.message")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
                .padding(.vertical, 10)
                
                Spacer()
            }
            .background(Color(.lightGray))
        }
    }
}

#Preview {
    ContentView()
}
