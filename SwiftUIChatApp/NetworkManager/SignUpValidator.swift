//
//  SignUpValidator.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 10/07/23.
//

import Foundation

struct SignUpValidator {
    func validateUser(userName: String, userEmail: String, userCountryCode: String, userMobile: String, userDOB: String, password: String, confirmPassword: String) -> ValidationResult {
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
//        let dob = DateFormatter.longDateFormatter.string(from: userDOB)
        guard userDOB.isNotEmpty else {
            return .failure(StringConstants.LoginSignUp.userDOBBlank)
        }
        guard password.isNotEmpty else {
            return .failure(StringConstants.LoginSignUp.passwordBlank)
        }
        guard confirmPassword.isNotEmpty else {
            return .failure(StringConstants.LoginSignUp.confirmPasswordBlank)
        }
        guard password == confirmPassword else {
            return .failure(StringConstants.LoginSignUp.confirmPasswordMatch)
        }
        return .success
    }
}

