//
//  CountryModel.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 11/07/23.
//

import Foundation

struct CountryList: Hashable, Codable {
    //    var id = UUID()
    var name: String?
    var code: String?
    var dial_code: String?
    var flag: String?
}
