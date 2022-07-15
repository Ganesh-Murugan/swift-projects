//
//  extensions.swift
//  Practice
//
//  Created by zoho on 10/06/22.
//

import Foundation

extension Int {
    var toString: String  {
        String(self)
    }
}

extension Optional {
    var unwrap: String {
        guard let self = self else { return "Unknown" }
        return self as! String
    }
    var intUnwrap: Int {
        guard let self = self else { return 0 }
        return self as! Int
    }
}

extension Array where Element == Contact {
    func searchFilter(searchText: String) -> [Contact] {
        return self.filter { searchText.isEmpty || (($0.name.unwrap).localizedStandardContains(searchText)) ||
            (($0.number?.toString).unwrap).localizedStandardContains(searchText)                                    }
    }

    func sort<T: Comparable>(_ property: (Element) -> T) -> [Element] {
        return self.sorted(by: {property($0) < property($1)})
    }
}

extension Array {
    func unique(_ selector:(Element,Element)->Bool) -> Array<Element> {
        return reduce(Array<Element>()){
            if let last = $0.last {
                return selector(last,$1) ? $0 : $0 + [$1]
            } else {
                return [$1]
            }
        }
    }
}
//
//extension Cell {
//    func addCell(_ index: Settings) {
//        self.settingName.text = index.settingName
//        self.settingDescription.text = index.settingDescription
//    }
//}
