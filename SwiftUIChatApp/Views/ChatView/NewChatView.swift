//
//  NewChatView.swift
//  SwiftUIChatApp
//
//  Created by Neosoft on 11/08/23.
//

import SwiftUI

struct NewChatView: View {
    @ObservedObject var viewModel : NewChatListViewModel = NewChatListViewModel()
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var sessionManager : SessionManager

    var body: some View {
        NavigationStack{
            VStack {
                List{
                    ForEach(viewModel.arrUsers, id: \.id) { userData in
                        //For hiding next arrow
                        ZStack {
                            UsersView(usersData: userData)
//                            let viewModel = SingleChatViewModel(iSessionManager: sessionManager, iChatUser: userData)
//                            NavigationLink(destination: SingleChatView(viewModel: viewModel)) {
//                                EmptyView()
//                            }
//                            .opacity(0)
                                                    NavigationLink(destination: OtherUserProfileView(userData: userData)) {
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
                .toolbar(.hidden, for: .tabBar)
                .navigationBarTitle("USER'S LIST",displayMode: .inline)
                .navigationBarBackButtonHidden()
                .navigationBarItems(leading: CustomBackButton())
                .onAppear(perform: {
                    viewModel.fetchUsersList()
                })
                .overlay{
                    LoadingView(showProgress: $viewModel.isLoading)
                }
            }
        }
    }
}

struct NewChatView_Previews: PreviewProvider {
    static var previews: some View {
        NewChatView()
    }
}