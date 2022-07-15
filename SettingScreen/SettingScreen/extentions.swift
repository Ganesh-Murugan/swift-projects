//
//  ext.swift
//  SettingScreen
//
//  Created by zoho on 16/06/22.
//

import Foundation
import UIKit
enum FontSet {
    case caption, body
}

extension UILabel {
    func initialLabelSetup() {
        self.translatesAutoresizingMaskIntoConstraints = false
//        self.adjustsFontSizeToFitWidth = true
    }
    
    func setFont(_ fontSet: FontSet) {
        switch fontSet{
        case .caption:
            self.font = .monospacedSystemFont(ofSize: 15, weight: .bold)
            self.textColor = .gray
            self.lineBreakMode = .byWordWrapping
            self.numberOfLines = 0
        case .body:
            self.font = .systemFont(ofSize: 18)
        }
    
    func setupAlignmentConstraints(centerXAnchor: NSLayoutXAxisAnchor?, xAnchorConstant: CGFloat, centerYAnchor: NSLayoutYAxisAnchor?, yAnchorConstant: CGFloat) {
        if let centerXAnchor = centerXAnchor {
            self.centerXAnchor.constraint(equalTo: centerXAnchor, constant: xAnchorConstant).isActive = true
        }
        if let centerYAnchor = centerYAnchor {
            self.centerYAnchor.constraint(equalTo: centerYAnchor, constant: yAnchorConstant).isActive = true
        }
    }
}
}
extension Cell {
    func addCell(_ index: Settings){
        self.settingName.text = index.settingName
        self.settingDescription.text = index.settingDescription
    }
}

extension UIView {
    func setupContraints(width: CGFloat, height: CGFloat, topAnchor: NSLayoutYAxisAnchor? = nil, topConstant: CGFloat? = nil, bottomAnchor: NSLayoutYAxisAnchor? = nil, bottomConstant: CGFloat? = nil, leadingAnchor: NSLayoutXAxisAnchor? = nil, leadingConstant: CGFloat? = nil, trailingAnchor: NSLayoutXAxisAnchor? = nil, trailingConstant: CGFloat? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let topAnchor = topAnchor, let topConstant = topConstant {
            self.topAnchor.constraint(equalTo: topAnchor, constant: topConstant).isActive = true
        }
        if let bottomAnchor = bottomAnchor, let bottomConstant = bottomConstant {
            self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomConstant).isActive = true
        }
        if let leadingAnchor = leadingAnchor, let leadingConstant = leadingConstant {
            self.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingConstant).isActive = true
        }
        if let trailingAnchor = trailingAnchor, let trailingConstant = trailingConstant {
            self.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingConstant).isActive = true
        }
        if height > 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width > 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
}
