//
//  Constants.swift
//  CollegeList
//
//  Created by zoho on 02/07/22.
//

import Foundation

struct Constants {
    
    struct Urls {
        static let countriesUrl = "https://api.first.org/data/v1/countries"
        static let collegesUrl = "http://universities.hipolabs.com/search"//search?country=India"
    }
    
    struct Identifiers {
        static let countryCellIdentifier = "countryCell"
        static let collegeCellIdentifier = "collegeCell"
    }
    
    struct Strings {
        static let persistentStorageModelName = "Model"

    }
}
