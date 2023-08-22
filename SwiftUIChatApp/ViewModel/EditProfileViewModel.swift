//
//  EditProfileViewModel.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 13/07/23.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore
import UIKit
import SwiftUI
import PhotosUI

class EditProfileViewModel: ObservableObject {
    
    @Published var user: AuthUserData?
    @Published var userId = ""
    @Published var userProfilePic = ""
    @Published var userName = ""
    @Published var userEmail = ""
    @Published var userCountryCode = ""
    @Published var userMobile = ""
    @Published var userGender = ""
    @Published var userDOB = ""
    @Published var selectedDOB : Date = Date.now
    @Published var selectedImage : UIImage? = nil
    @Published var selectedImageData : Data? = nil
    @Published var selectedItem: PhotosPickerItem? = nil

    @Published var errorMessage = ""
    @Published var showAlert = false
    @Published var isProfileUpdated = false
    @Published var isLoading: Bool = false

    let sessionManager: SessionManager?
    
    init(iSessionManager: SessionManager?, iUserData: AuthUserData?) {
        self.user = iUserData
        self.sessionManager = iSessionManager
        if let userData = self.user {
            DispatchQueue.main.async {
                self.userName = userData.name ?? ""
                self.userEmail = userData.email ?? ""
                self.userCountryCode = userData.countryCode ?? ""
                self.userMobile = userData.mobile ?? ""
                self.userDOB = userData.dob ?? ""
                self.userGender = userData.gender ?? ""
                self.selectedImageData = try! Data(contentsOf: URL(string: userData.profilePic ?? "")!)
                if let imgData = self.selectedImageData, let uiImage = UIImage(data: imgData) {
                    self.selectedImage = uiImage
                }
                self.selectedDOB = DateFormatter.stringToDateFormatter.date(from: userData.dob ?? "") ?? Date.now
                self.userId = userData.userId ?? ""
            }
        }
    }
    
    //    func fetchUser() {
    //        guard let uid = Auth.auth().currentUser?.uid else { return }
    //        let userRef = Firestore.firestore().collection("users").document(uid)
    //        userRef.getDocument { (document, error) in
    //            if let document = document, document.exists {
    //                if let user = AuthUserData(document: document) {
    //                    self.user = user
    //                    if let userData = self.user {
    //                        self.userName = userData.name ?? ""
    //                        self.userEmail = userData.email ?? ""
    //                        self.userCountryCode = userData.countryCode ?? ""
    //                        self.userMobile = userData.mobile ?? ""
    //                        self.userDOB = userData.dob ?? Date()
    //                        self.userGender = userData.gender ?? ""
    //                        self.selectedImageData = try! Data(contentsOf: URL(string: userData.profilePic ?? "")!)
    //                    }
    //                }
    //            } else {
    //                print("Document does not exist or there was an error: \(error?.localizedDescription ?? "")")
    //            }
    //        }
    //    }
    
    func editProfile() {
        self.isLoading = true
        hideKeyboard()
        let response = EditProfileValidator().validateUser(userName: self.userName, userEmail: self.userEmail, userCountryCode: self.userCountryCode, userMobile: self.userMobile, userDOB: DateFormatter.longDateFormatter.string(from: self.selectedDOB))
        switch response {
        case .success:
            self.showAlert = false
            self.uploadUserProfile()
            break
        case .failure(let msg):
            self.showAlert = true
            self.isLoading = false
            self.errorMessage = msg
        }
    }
    
    func uploadUserProfile() {
        self.sessionManager?.uploadImageToFirebaseStorage(image: self.selectedImage) { imageUrl, failure in
            if failure.isNotEmpty {
                self.errorMessage = failure
                self.showAlert = true
                self.isLoading = false
            } else {
                self.userProfilePic = imageUrl
                let updatedData: [String: Any] = [
                    "profilePic": self.userProfilePic,
                    "name": self.userName,
                    "email": self.userEmail,
                    "dob": DateFormatter.longDateFormatter.string(from: self.selectedDOB),
                    "gender": self.userGender,
                    "countryCode": self.userCountryCode,
                    "mobile": self.userMobile,
                    "userId": self.userId
                ]
                
                // Call the function to update user information
                self.sessionManager?.updateUserInformation(userData: updatedData) { success, error in
                    let err = error
                    if err.isNotEmpty {
                        self.errorMessage = err
                        self.showAlert = true
                        self.isLoading = false
                    } else {
                        self.isProfileUpdated = true
                        self.showAlert = true
                        self.isLoading = false
                    }
                }
            }
        }
    }
}
