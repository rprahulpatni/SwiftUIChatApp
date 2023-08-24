//
//  LocalDataManager.swift
//  SwiftUIDemo
//
//  Created by Neosoft on 07/06/23.
//

import Foundation

struct BundleDecoderFromJson {
    static func decodeCountryListFromBundleToJson() -> [CountryList] {
        let countryJson = Bundle.main.path(forResource: "LocalCountryCodes", ofType: "json")
        let countryData = try! Data(contentsOf: URL(fileURLWithPath: countryJson!), options: .alwaysMapped)
        return try! JSONDecoder().decode([CountryList].self, from: countryData)
    }
}
