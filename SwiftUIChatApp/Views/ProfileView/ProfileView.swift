//
//  ProfileView.swift
//  SwiftUIChatApp
//
//  Created by Neosoft on 11/08/23.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct ProfileView: View {
    @State private var shouldShowLogOutOptions = false
    @StateObject private var viewModel = UserViewModel()
    @EnvironmentObject var sessionManager : SessionManager
    
    var body: some View {
        NavigationStack{
            VStack{
                CustomUserForm(user: self.viewModel.user)
                    .onAppear(perform: {
                        viewModel.fetchUser(getUID())
                    })
                    //.modifier(CustomLoaderModifier(isLoading: self.$viewModel.isLoading))
            }.navigationBarTitle("PROFILE", displayMode: .inline)
                .toolbar {
                    NavigationLink(destination: EditProfileView(viewModel: EditProfileViewModel(iSessionManager: self.sessionManager, iUserData: self.viewModel.user))) {
                        Image(systemName: "square.and.pencil.circle")
                    }
                    Button(action: {
                        self.shouldShowLogOutOptions = true
                    }, label: {
                        Image(systemName: "iphone.and.arrow.forward")
                    })
                    .alert(isPresented: $shouldShowLogOutOptions) {
                        Alert(title: Text("Are you sure you want to logout?"), primaryButton: .destructive(Text("OK"), action: {
                            SessionManager.shared.logout()
                        }), secondaryButton: .cancel(Text("Cancel"), action: {
                            self.shouldShowLogOutOptions = false
                        }))
                    }
                }
        }
        .overlay{
            LoadingView(showProgress: $viewModel.isLoading)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
