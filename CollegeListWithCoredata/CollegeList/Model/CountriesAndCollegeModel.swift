//
//  CollegesModel.swift
//  CollegeList
//
//  Created by zoho on 04/07/22.
//

import Foundation


//struct CollegeApiResponse: Decodable {
//    var colleges: [College]?
//}


struct CountriesAndCollegesModel: Decodable {
//    var domains: [String]?
//    var webPages: [String]?
        var collegeName: String?
        var countryName: String?
        enum CodingKeys: String, CodingKey {
            case collegeName = "name"
            case countryName = "country"
        }
//    var alphaTwoCode: String
    
}
