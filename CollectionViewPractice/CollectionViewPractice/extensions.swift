//
//  extensions.swift
//  CollectionViewPractice
//
//  Created by zoho on 21/06/22.
//

import Foundation
import UIKit

extension Int {
    var formatDecimal: String  {
        String(self)
    }
}
extension String {
    var toInt: Int {
        Int(self) ?? 0
    }
    var toDouble: Double {
        Double(self) ?? 0
    }
    func filterValues(value: String) -> String {
        return self.filter{ value.contains($0)}
    }
    func removeEqual() -> String {
        return self.filter{ "0123456789-+/*%.<".contains($0) }
    }
    
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
    
    mutating func convertFloat(_ operation: String){
        if !self.contains(".") {
        self.removeLast()
        self += ".0 \(operation)"
        }
    }
    mutating func backSpace(_ count: Int){
        self = self.dropLast(count).toString
    }
    func previousValue() {
        
    }
}
extension Substring {
    var toString: String  {
        String(self)
    }
}

extension Double {
    var isInteger: Bool { rounded() == self }
    var formatDecimal: String {
        return self.isInteger ? String(format: "%0.0f", self) : String(format: "%0.2f", self)
    }
    var toString: String  {
        String(self)
    }
}

extension Array where Element == Int {
    var toString: [String] {
        return self.map({$0.formatDecimal})
    }
}


enum FontSet {
    case caption, body, title
}
extension UILabel {
    
    func setFont(_ fontSet: FontSet) {
        switch fontSet{
        case . title:
            self.font = .monospacedDigitSystemFont(ofSize: 20, weight: .bold)
        case .caption:
            self.font = .monospacedSystemFont(ofSize: 15, weight: .bold)
            self.textColor = .gray
            self.lineBreakMode = .byWordWrapping
            self.numberOfLines = 0
        case .body:
            self.font = .systemFont(ofSize: 18)
        }
    }
}

