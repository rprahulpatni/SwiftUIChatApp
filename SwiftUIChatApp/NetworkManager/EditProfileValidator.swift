//
//  EditProfileValidator.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 21/07/23.
//

import Foundation

struct EditProfileValidator {
    
    func validateUser(userName: String, userEmail: String, userCountryCode: String, userMobile: String, userDOB: String) -> ValidationResult {
        guard userName.isNotEmpty else {
            return .failure(StringConstants.LoginSignUp.userNameBlank)
        }
        guard userEmail.isNotEmpty else {
            return .failure(StringConstants.LoginSignUp.userEmailBlank)
        }
        guard userEmail.isValidEmail else {
            return .failure(StringConstants.LoginSignUp.userEmailValid)
        }
        guard userCountryCode.isNotEmpty else {
            return .failure(StringConstants.LoginSignUp.userCountryCodeBlank)
        }
        guard userMobile.isNotEmpty else {
            return .failure(StringConstants.LoginSignUp.userMobileBlank)
        }
        guard userMobile.isValidMobile else {
            return .failure(StringConstants.LoginSignUp.userMobileValid)
        }
        guard userDOB.isNotEmpty else {
            return .failure(StringConstants.LoginSignUp.userDOBBlank)
        }
        return .success
    }
}
