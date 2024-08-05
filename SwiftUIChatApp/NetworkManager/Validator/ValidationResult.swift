//
//  ValidationResult.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 21/07/23.
//

import Foundation

enum ValidationResult: Equatable {
    case success
    case failure(String)
    
    static func ==(lhs: ValidationResult, rhs: ValidationResult) -> Bool {
        switch (lhs, rhs) {
        case (.success, .success):
            return true
        case (.failure(let leftMessage), .failure(let rightMessage)):
            return leftMessage == rightMessage
        default:
            return false
        }
    }
}
