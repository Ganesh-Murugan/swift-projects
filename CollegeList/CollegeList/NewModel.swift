//
//  NewModel.swift
//  CollegeList
//
//  Created by zoho on 11/07/22.
//

import Foundation

struct CountriesAndColleges: Decodable {
    var countriesAndColleges: [NewModel]
    enum CodingKeys: String, CodingKey {
        case countriesAndColleges = "domains"
    }
}

struct NewModel: Decodable {
    var collegeName: String
    var countryName: String
    enum CodingKeys: String, CodingKey {
        case collegeName = "name"
        case countryName = "country"
    }
}
