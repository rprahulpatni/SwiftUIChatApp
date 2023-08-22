//
//  ContentView.swift
//  SwiftUIChatApp
//
//  Created by Neosoft on 11/08/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView{
            ChatListView()
                .tabItem({
                    Label("Chats", systemImage: "ellipsis.message.fill")
                })
                .tag(1)
            ProfileView()
                .tabItem({
                    Label("Profile", systemImage: "person.fill")
                })
                .tag(2)
        }
        .accentColor(.teal)
        .navigationBarBackButtonHidden()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
