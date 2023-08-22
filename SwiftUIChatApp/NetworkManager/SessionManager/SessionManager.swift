//
//  SessionManager.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 07/06/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseStorage

class SessionManager: NSObject, ObservableObject {
    
    @Published var loggedUser: User?
    static let shared = SessionManager()
    private let auth = Auth.auth()
    
    var handle : AuthStateDidChangeListenerHandle?
    
    override private init() {
        loggedUser = auth.currentUser
        super.init()
        //handle = auth.addStateDidChangeListener(authStateChanged)
    }
    
    //    private func authStateChanged(with auth: Auth, user: User?) {
    //        guard user != self.loggedUser else { return }
    //        self.loggedUser = user
    //    }
    
    func action_Login(_ email: String, _ password: String, compelition: @escaping(_ success: Bool, _ failure: String, _ userData: User?) -> Void) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                compelition(false, error?.localizedDescription ?? "", nil)
            } else {
                compelition(true, "", result?.user ?? nil)
            }
        }
    }
    
    func action_Signup(_ email: String, _ password: String, compelition: @escaping(_ success: Bool, _ failure: String, _ userData: User?) -> Void) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                compelition(false, error?.localizedDescription ?? "", nil)
            } else {
                compelition(true, "", result?.user ?? nil)
            }
        }
    }
    
    func logout() {
        do {
            try auth.signOut()
            self.loggedUser = nil
        } catch(let error) {
            debugPrint(error.localizedDescription)
        }
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
}

extension SessionManager {
    func addUserInformation(userData: [String: Any], completion: @escaping (Bool, String) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // Add the user document in Firestore with the additional information
        let usersRef = Database.database().reference().child("users")
        usersRef.child(uid).setValue(userData) { (error, reference) in
            if let err = error {
                completion(false, err.localizedDescription)
            } else {
                completion(true, "")
            }
        }
        //        let userRef = Firestore.firestore().collection("users").document(uid)
        //        userRef.setData(userData) { error in
        //            if let err = error {
        //                completion(false, err.localizedDescription)
        //            } else {
        //                completion(true, "")
        //            }
        //        }
    }
    
    func updateUserInformation(userData: [String: Any], completion: @escaping (Bool, String) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let usersRef = Database.database().reference().child("users")
        usersRef.child(uid).updateChildValues(userData) { (error, reference) in
            if let err = error {
                completion(false, err.localizedDescription)
            } else {
                completion(true, "")
            }
        }
//        let userRef = Firestore.firestore().collection("users").document(uid)
//        //Update the user document in Firestore with the additional information
//        userRef.updateData(userData) { error in
//            if let err = error {
//                completion(false, err.localizedDescription)
//            } else {
//                completion(true, "")
//            }
//        }
    }
    
    func uploadImageToFirebaseStorage(image: UIImage?, completion: @escaping (_ success: String, _ failure: String) -> Void) {
        guard let imageData = image?.jpegData(compressionQuality: 0.5) else {
            completion("", "Failed to convert image to data")
            return
        }
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("images/\(uid).jpg")
        let uploadTask = storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let err = error {
                completion("", err.localizedDescription)
                return
            }
            storageRef.downloadURL { (url, error) -> Void in
                if let err = error {
                    completion("", err.localizedDescription)
                } else if let downloadURL = url {
                    completion(downloadURL.absoluteString, "")
                }
            }
        }
        uploadTask.resume()
    }
}
