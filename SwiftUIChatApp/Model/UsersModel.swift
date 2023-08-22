//
//  UsersModel.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 08/06/23.
//

import Foundation
struct APIResponseModel: Decodable {
    let message: String
    let errorMsg: String
    let errorCode: Int
}

struct UsersModel: Decodable {
    let users: [UsersData]
    let total, skip, limit: Int
}

// MARK: - User
struct UsersData: Decodable {
    let id: Int
    let firstName, lastName, maidenName: String
    let age: Int
    let gender, email, phone, username: String
    let password, birthDate: String
    let image: String
    let bloodGroup: String
    let height: Int
    let weight: Double
    let eyeColor: String
    let hair: HairData
    let domain, ip: String
    let address: AddressData
    let macAddress, university: String
    let bank: BankData
//    let company: CompanyData
//    let ein, ssn, userAgent: String
}

// MARK: - Address
struct AddressData: Decodable {
    let address: String
    let city: String?
    let coordinates: CoordinatesData
    let postalCode, state: String
}

// MARK: - Coordinates
struct CoordinatesData: Decodable {
    let lat, lng: Double
}

// MARK: - Bank
struct BankData: Decodable {
    let cardExpire, cardNumber, cardType, currency: String
    let iban: String
}

// MARK: - Company
struct CompanyData: Decodable {
    let address: AddressData
    let department, name, title: String
}

// MARK: - Hair
struct HairData: Decodable {
    let color, type: String
}
