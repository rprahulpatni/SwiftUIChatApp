//
//  LoginViewModel.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 10/07/23.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore
import UIKit

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var isLoggedIn = false
    @Published var showAlert = false
    @Published var isLoading: Bool = false
    @Published var user: AuthUserData?

    let sessionManager: SessionManager?
    var loggedInUser : User?

    init(iSessionManager: SessionManager?) {
        self.sessionManager = iSessionManager
    }
    
    func login() {
        self.isLoading = true
        hideKeyboard()
        let validationResult = LoginValidator().validateUser(userEmail: self.email, password: self.password)
        switch validationResult {
        case .success:
            sessionManager?.action_Login(self.email, self.password) { [weak self] (success, error, result) in
                guard let self = self else { return }
                let err = error
                if err.isNotEmpty {
                    self.errorMessage = err
                    self.showAlert = true
                    self.isLoading = false
                } else {
                    self.fetchUser(result)
                }
            }
            
        case .failure(let msg):
            self.errorMessage = msg
            self.showAlert = true
            self.isLoading = false
        }
    }
    
    func fetchUser(_ userData: User?) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let usersRef = Database.database().reference().child("users")
        usersRef.child(uid).observeSingleEvent(of: .value) { snapshot in
            if let userInfo = snapshot.value as? [String: Any] {
                // Access user information here
                print("User Info: \(userInfo)")
                self.user = AuthUserData(profilePic: userInfo["profilePic"] as? String ?? "", name:  userInfo["name"] as? String ?? "", email:  userInfo["email"] as? String ?? "", dob:  userInfo["dob"] as? String ?? "", gender:  userInfo["gender"] as? String ?? "", countryCode:  userInfo["countryCode"] as? String ?? "", mobile:  userInfo["mobile"] as? String ?? "", userId: userInfo["userId"] as? String ?? "")
                self.loggedInUser = userData
                self.showAlert = true
                self.isLoggedIn = true
                self.isLoading = false
            } else {
                print("User information not found")
                self.showAlert = true
                self.isLoading = false
            }
        }
    }
}
