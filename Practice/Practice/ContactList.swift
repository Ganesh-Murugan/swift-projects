//
//  ContactList.swift
//  Practice
//
//  Created by zoho on 15/06/22.
//

import Foundation

struct Contacts {
    var sortedList = contacts.sort{$0.name.unwrap}.unique({$0.name == $1.name})
    var sectionTitle: [String]{
        sortedList.map({$0.firstLetter}).unique({$0 == $1})
    }
    var contactDict = [String:[Contact]]()
}
