//
//  CountriesAndColleges+CoreDataProperties.swift
//  CollegeList2
//
//  Created by zoho on 12/07/22.
//
//

import Foundation
import CoreData


extension CountriesAndColleges {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountriesAndColleges> {
        return NSFetchRequest<CountriesAndColleges>(entityName: "CountriesAndColleges")
    }
   
    @NSManaged public var collegeName: String?
    @NSManaged public var countryName: String?
}

extension CountriesAndColleges : Identifiable {
}
