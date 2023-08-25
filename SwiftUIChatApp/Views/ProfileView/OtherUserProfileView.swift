//
//  OtherUserProfileView.swift
//  SwiftUIChatApp
//
//  Created by Neosoft on 16/08/23.
//

import SwiftUI

struct OtherUserProfileView: View {
//    var userData: AuthUserData?
//    @EnvironmentObject var sessionManager : SessionManager
    @StateObject private var viewModel = UserViewModel()
    var uid: String? = ""
    
    var body: some View {
        VStack {
            CustomUserForm(user: self.viewModel.user)
                .onAppear(perform: {
                    viewModel.fetchUser(uid)
                })
        }.toolbar(.hidden, for: .tabBar)
            .navigationBarTitle("USER PROFILE", displayMode: .inline)
            .navigationBarBackButtonHidden()
            .navigationBarItems(leading: CustomBackButton())
//            .toolbar {
//                //Navigate to SearchView on click of Search NavigationLink
//                NavigationLink{
//                    let viewModel = SingleChatViewModel(iSessionManager: sessionManager, iChatUser: userData)
//                    SingleChatView(viewModel: viewModel)
//                } label: {
//                    Image(systemName: "ellipsis.message.fill")
//                        .foregroundColor(.teal)
//                }
//            }
    }
}

//struct OtherUserProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        OtherUserProfileView()
//    }
//}
