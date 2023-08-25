//
//  NewChatView.swift
//  SwiftUIChatApp
//
//  Created by Neosoft on 11/08/23.
//

import SwiftUI

struct NewChatView: View {
    @Binding var selectedUser: AuthUserData
    @Binding var isUserListVisible: Bool
    @Binding var showNewChat: Bool

    @ObservedObject private var viewModel : NewChatListViewModel = NewChatListViewModel()
    //    @Environment(\.dismiss) private var dismiss
    //    @EnvironmentObject var sessionManager : SessionManager
    
    var body: some View {
        ZStack{
            VStack {
                HStack(alignment: .center){
                    Text("Cancel")
                        .foregroundColor(.clear)
                    Spacer()
                    Text("USER LIST")
                        .font(.headline)
                    Spacer()
                    Button("Cancel", role: .cancel, action: {
                        self.isUserListVisible = false
                        self.showNewChat = false
                    })
                }.padding(.horizontal)
                SearchBar(text: $viewModel.searchText)
                List(self.viewModel.filteredPost, id: \.id){ userData in
                    Button(action: {
                        self.selectedUser = userData
                        self.isUserListVisible = false
                        self.showNewChat = true
                    }, label: {
                        UsersView(usersData: userData)
                    })
                    //                ForEach(viewModel.arrUsers, id: \.id) { userData in
                    //                    //For hiding next arrow
                    //                    ZStack {
                    //                        UsersView(usersData: userData)
                    //                        //                            let viewModel = SingleChatViewModel(iSessionManager: sessionManager, iChatUser: userData)
                    //                        //                            NavigationLink(destination: SingleChatView(viewModel: viewModel)) {
                    //                        //                                EmptyView()
                    //                        //                            }
                    //                        //                            .opacity(0)
                    //                        //                                                    NavigationLink(destination: OtherUserProfileView(userData: userData)) {
                    //                        //                                                        EmptyView()
                    //                        //                                                    }
                    //                        //                                                    .opacity(0)
                    //                    }
                    //                }
                    .listRowSeparator(.hidden,edges: .all)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                }
                .listStyle(.plain)
                .toolbar(.hidden, for: .tabBar)
                .navigationBarTitle("USER'S LIST",displayMode: .inline)
                .navigationBarBackButtonHidden()
                .navigationBarItems(leading: CustomBackButton())
                .searchable(text: $viewModel.searchText)
                .onAppear(perform: {
                    viewModel.fetchUsersList()
                })
                .overlay{
                    LoadingView(showProgress: $viewModel.isLoading)
                }
            }.padding(.top, 60)
        }.ignoresSafeArea()
    }
}

//struct NewChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewChatView(viewModel: <#NewChatListViewModel#>, selectedUserId: .constant(""), isUserListVisible: .constant(false))
//    }
//}
