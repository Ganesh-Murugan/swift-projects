//
//  ContriesModel.swift
//  CollegeList
//
//  Created by zoho on 02/07/22.
//

import Foundation

struct CountryApiResponse: Decodable {
//    var status: String?
//    var version: String?
//    var access: String?
    var data: [String : Countries]?
}

struct Countries: Decodable {
    var country: String?
    var region: String?
}
