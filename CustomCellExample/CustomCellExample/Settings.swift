//
//  Settings.swift
//  CustomCellExample
//
//  Created by zoho on 16/06/22.
//

import Foundation

enum SettingType: Equatable {
    case toggle(_ toggled: Bool), navigate
}

struct Settings {
    var settingName: String
    var settingType: SettingType
    var settingDescription: String
    
}

var settings = [
    Settings(settingName: "App", settingType: .navigate, settingDescription: "App Related Settings"),
    Settings(settingName: "wifi", settingType: .toggle(true), settingDescription: "turn on or off wifi"),
    Settings(settingName: "airoplane mode", settingType: .toggle(false), settingDescription: "turn on or off aeroplane mode"),
    Settings(settingName: "about" , settingType: .navigate, settingDescription: "About phone"),
]
