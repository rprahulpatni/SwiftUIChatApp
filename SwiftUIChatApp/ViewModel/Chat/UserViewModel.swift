//
//  UserViewModel.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 13/07/23.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore
import UIKit

class UserViewModel: ObservableObject {
    @Published var user: AuthUserData?
    @Published var isLoading: Bool = false

//    func fetchUser() {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        let userRef = Firestore.firestore().collection("users").document(uid)
//        userRef.getDocument { (document, error) in
//            if let document = document, document.exists {
//                if let user = AuthUserData(document: document) {
//                    self.user = user
//                }
//            } else {
//                print("Document does not exist or there was an error: \(error?.localizedDescription ?? "")")
//            }
//        }
//    }
    
    func fetchUser() {
        self.isLoading = true
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let usersRef = Database.database().reference().child("users")
        usersRef.child(uid).observeSingleEvent(of: .value) { snapshot in
            if let userInfo = snapshot.value as? [String: Any] {
                // Access user information here
                print("User Info: \(userInfo)")
                self.user = AuthUserData(profilePic: userInfo["profilePic"] as? String ?? "", name:  userInfo["name"] as? String ?? "", email:  userInfo["email"] as? String ?? "", dob:  userInfo["dob"] as? String ?? "", gender:  userInfo["gender"] as? String ?? "", countryCode:  userInfo["countryCode"] as? String ?? "", mobile:  userInfo["mobile"] as? String ?? "", userId: userInfo["userId"] as? String ?? "")
                self.isLoading = false
            } else {
                print("User information not found")
                self.isLoading = false
            }
        }
    }
}
