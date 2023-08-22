//
//  SignUpViewModel.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 10/07/23.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore
import UIKit
import PhotosUI
import SwiftUI

class SignUpViewModel: ObservableObject {
    @Published var userProfilePic = ""
    @Published var userName = ""
    @Published var userEmail = ""
    @Published var userCountryCode = ""
    @Published var userMobile = ""
    @Published var userGender = ""
    @Published var userDOB = ""
    @Published var userPassword = ""
    @Published var userConfirmPassword = ""
    @Published var userId = ""
    @Published var selectedDOB : Date = Date.now
    @Published var selectedImage : UIImage? = nil
    @Published var selectedImageData : Data? = nil
    @Published var selectedItem: PhotosPickerItem? = nil

    @Published var errorMessage = ""
    @Published var showAlert = false
    @Published var isLoggedIn = false
    @Published var isLoading: Bool = false

    let sessionManager: SessionManager?
    var loggedInUser : User?
    
    init(iSessionManager: SessionManager?) {
        self.sessionManager = iSessionManager
    }
    
    func signUp() {
        self.isLoading = true
        hideKeyboard()
        let validationResult = SignUpValidator().validateUser(userName: self.userName, userEmail: self.userEmail, userCountryCode: self.userCountryCode, userMobile: self.userMobile, userDOB: DateFormatter.longDateFormatter.string(from: self.selectedDOB), password: self.userPassword, confirmPassword: self.userConfirmPassword)
        switch validationResult {
        case .success:
            sessionManager?.action_Signup(self.userEmail, self.userPassword) { [weak self] (success, error, result) in
                guard let self = self else { return }
                let err = error
                if err.isNotEmpty {
                    self.errorMessage = err
                    self.showAlert = true
                } else {
                    self.loggedInUser = result
                    self.showAlert = false
                    self.isLoading = false
                    self.uploadUserProfile()
                }
            }
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
                self.userId = self.loggedInUser?.uid ?? ""
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
                self.sessionManager?.addUserInformation(userData: updatedData) { success, error in
                    let err = failure
                    if err.isNotEmpty {
                        self.errorMessage = err
                        self.showAlert = true
                        self.isLoading = false
                    } else {
                        self.isLoggedIn = true
                        self.showAlert = true
                        self.isLoading = false
                    }
                }
            }
        }
    }
}


