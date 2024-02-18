//
//  TabView.swift
//  Snoozer
//
//  Created by David Strupinski on 2/17/24.
//

import SwiftUI

struct TabView: View {
    var body: some View {
        HStack {
            Spacer()
            
            NavigationLink(destination: ProfileView()) {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
            .padding(.vertical, 10)
            
            Spacer()
            
            NavigationLink(destination: AlarmView()) {
                Image(systemName: "plus.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
            }
            .padding(.bottom, 20)
            
            Spacer()
            
            NavigationLink(destination: ChatView()) {
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
