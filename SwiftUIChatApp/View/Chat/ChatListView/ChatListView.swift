//
//  ChatListView.swift
//  SwiftUIChatApp
//
//  Created by Neosoft on 11/08/23.
//

import SwiftUI

struct ChatListView: View {
    @State var showNewChat: Bool = false
    @StateObject private var viewModel = ChatListViewModel()
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(viewModel.msgData, id: \.id) { msgData in
                    //For hiding next arrow
                    ZStack {
                        ChatListRow(msgData: msgData, uid: getUID())
                        let userData = AuthUserData(id: UUID(), profilePic: msgData.senderId == getUID() ? msgData.receiverPhoto : msgData.senderPhoto, name: msgData.senderId == getUID() ? msgData.receiverName : msgData.senderName, email: "", dob: "", gender: "", countryCode: "", mobile: "", userId: msgData.senderId == getUID() ? msgData.receiverId : msgData.senderId)
                        let viewModel = SingleChatViewModel(iChatUser: userData)
                        NavigationLink(destination: SingleChatView(viewModel: viewModel)) {
                            EmptyView()
                        }
                        .opacity(0)
                    }
                }
                .listRowSeparator(.hidden,edges: .all)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.plain)
            .onAppear{
                self.viewModel.fetchMessages()
            }
            .overlay{
                LoadingView(showProgress: $viewModel.isLoading)
            }
            .navigationBarTitle("CHAT LIST", displayMode: .inline)
            .navigationDestination(isPresented: $showNewChat, destination:{
                NewChatView()
            })
            .overlay(alignment: .bottomTrailing) {
                Button(action: {
                    showNewChat.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(15)
                        .background(.teal, in: Circle())
                })
                .padding(15)
            }
        }
    }
}

struct ChatListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatListView()
    }
}
