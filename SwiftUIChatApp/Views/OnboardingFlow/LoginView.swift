//
//  LoginView.swift
//  SwiftUIChatApp
//
//  Created by NeoSOFT on 24/08/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel

    init(viewModel: LoginViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack{
            ScrollView(.vertical, showsIndicators: false) {
                Spacer()
                VStack() {
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .textFieldStyle(CustomTxtFieldStyle())
                        .padding(.bottom, 5)
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(CustomTxtFieldStyle())
                        .padding(.bottom)
                    Button(action: {
                        viewModel.login()
                    }, label: {
                        Text("Sign In")
                    }).buttonStyle(CustomBtn())
                        .alert(isPresented: $viewModel.showAlert) {
                            if  viewModel.isLoggedIn {
                                return Alert(title: Text("Alert"), message: Text("Logged In Successfull !!"), dismissButton: .default(Text("OK")) {
                                    let changeRequest = Auth.auth().currentUser!.createProfileChangeRequest()
                                    changeRequest.photoURL = URL(string: self.viewModel.user?.profilePic ?? "")
                                    changeRequest.displayName = self.viewModel.user?.name ?? ""
                                    changeRequest.commitChanges { error in
                                        if let error = error {
                                            print("Error updating profile : \(error.localizedDescription)")
                                        } else {
                                            print("Profile updated successfully!")
                                        }
                                    }
                                    self.viewModel.sessionManager?.loggedUser = self.viewModel.loggedInUser
                                })
                            } else  {
                                return Alert(title: Text("Alert"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")) {
                                })
                            }
                        }
                }
                .padding()
                .navigationBarTitle("LOGIN", displayMode: .inline)
                .navigationBarBackButtonHidden()
                .navigationBarItems(leading: CustomBackButton())
            }
            .modifier(CustomHideKeyboardModifier())
        }
        .overlay{
            LoadingView(showProgress: $viewModel.isLoading)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(iSessionManager: nil))
    }
}
