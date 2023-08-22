//
//  AuthUserModel.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 13/07/23.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore
import UIKit

struct UpdatedUserData: Codable {
    var profilePic: String?
    var name: String?
    var email: String?
    var dob: Date?
    var gender: String?
    var countryCode: String?
    var mobile: String?
    
    enum CodingKeys: String, CodingKey {
        case profilePic = "profilePic"
        case name = "name"
        case email = "email"
        case dob = "dob"
        case gender = "gender"
        case countryCode = "countryCode"
        case mobile = "mobile"
    }
}

struct AuthUserData: Hashable {
    var id: UUID = UUID()
    var profilePic: String?
    var name: String?
    var email: String?
    var dob: String?
    var gender: String?
    var countryCode: String?
    var mobile: String?
    var userId: String?
    
//    init?(document: DocumentSnapshot) {
//        let data = document.data()
//        self.profilePic = data?["profilePic"] as? String
//        self.name = data?["name"] as? String
//        self.email = data?["email"] as? String
//        self.dob = data?["dob"] as? Date
//        self.gender = data?["gender"] as? String
//        self.countryCode = data?["countryCode"] as? String
//        self.mobile = data?["mobile"] as? String
//    }
}
