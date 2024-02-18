//
//  AlarmView.swift
//  Snoozer
//
//  Created by David Strupinski on 2/10/24.
//

import Foundation
import SwiftUI

struct AlarmView: View {
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
            
            // streaks
            HStack (spacing: 0) {
                Spacer()
                
                Text("3")
                Image(systemName: "flame.fill")
                    .padding(.trailing, 10.0)
                
                Text("ENDS STREAK")
                
                Spacer()
            }
            .padding(.bottom, 50)
        }
    }
}
