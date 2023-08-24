//
//  LoginValidator.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 10/07/23.
//

import Foundation
struct LoginValidations {
    func validateUser(userEmail: String, password: String) -> ValidationResult {
        guard userEmail.isNotEmpty else {
            return .failure(StringConstants.LoginSignUp.userEmailBlank)
        }
        guard userEmail.isValidEmail else {
            return .failure(StringConstants.LoginSignUp.userEmailValid)
        }
        guard password.isNotEmpty else {
            return .failure(StringConstants.LoginSignUp.passwordBlank)
        }
        return .success
    }
}
