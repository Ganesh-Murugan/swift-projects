//
//  extensions.swift
//  AppScreen
//
//  Created by zoho on 21/06/22.
//

import Foundation
import UIKit
enum FontSet {
    case caption, body
}
extension UILabel {
    
    func setFont(_ fontSet: FontSet) {
        switch fontSet{
        case .caption:
            self.font = .monospacedSystemFont(ofSize: 11, weight: .medium)
            self.textColor = .gray
            self.lineBreakMode = .byWordWrapping
            self.numberOfLines = 0
        case .body:
            self.font = .systemFont(ofSize: 18)
        }
    }
}
