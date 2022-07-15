//
//  Settings.swift
//  CustomCellExample
//
//  Created by zoho on 16/06/22.
//

import Foundation
import UIKit
enum Navigate {
    case displaySettings, about
}
enum SettingType: Equatable {
    case toggle(_ toggled: Bool), navigate(navigateTo: Navigate), slider(_ sliderValue: Float), about
}
struct Settings: Equatable {
    var settingName: String
    var settingType: SettingType
    var settingDescription: String
    
}

protocol Cell: UITableViewCell {
    var settingName: UILabel { get }
    var settingDescription: UILabel { get }
//    func setNameConstraints()
//    func setDescriptionConstraints()
}

var settings = [
    Settings(settingName: "Display", settingType: .navigate(navigateTo: .displaySettings), settingDescription: "App Related Settings"),
    Settings(settingName: "wifi", settingType: .toggle(true), settingDescription: "turn on or off wifi"),
    Settings(settingName: "airoplane mode", settingType: .toggle(false), settingDescription: "turn on or off aeroplane mode"),
    Settings(settingName: "about" , settingType: .navigate(navigateTo: .about), settingDescription: "About phone"),
]

var displaySettings = [
    Settings(settingName: "brightness", settingType: .slider(0.2), settingDescription: "Adjust brightness"),
    Settings(settingName: "OutDoor mode", settingType: .toggle(false), settingDescription: "make the screen brighter for outdoor view make the screen brighter for outdoor view"),
    Settings(settingName: "blue light filter", settingType: .toggle(false), settingDescription: "filter blue light")
]


var about = [
    Settings(settingName: "IOS Version", settingType: .about, settingDescription: "14"),
    Settings(settingName: "Model Name", settingType: .about, settingDescription: "Iphone 12 Pro Max")
]
