//
//  AppSettingsCell.swift
//  SettingScreen
//
//  Created by zoho on 17/06/22.
//

import UIKit

class SliderCell: UITableViewCell, Cell{
    var settingName = UILabel()
    var settingDescription = UILabel()
    var slider = UISlider()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addFrame(contentView.bounds.width, contentView.bounds.height)
        contentView.addSubview(slider)
        contentView.addSubview(settingName)
        settingName.setFont(.body)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addFrame(_ contentWidth: CGFloat, _ contentHeight: CGFloat) {
        slider.frame = CGRect(x: 25, y: contentHeight, width: contentWidth, height: 10)
        settingName.frame = CGRect(x: 15, y: 5, width: contentWidth, height: 20)
        //settingDescription.frame = CGRect(x: 15, y: contentHeight/1.3, width: contentWidth - 50, height: 55)
        
    }
}



extension SliderCell {
    func setNameConstraints() {
//        settingName.setupAlignmentConstraints(centerXAnchor: nil, xAnchorConstant: 10, centerYAnchor: centerYAnchor, yAnchorConstant: 0)
    }
    
    func setDescriptionConstraints() {
//          settingDescription.setupAlignmentConstraints(centerXAnchor: centerXAnchor, xAnchorConstant: 0, centerYAnchor: nil, yAnchorConstant: 0)
//
    }
}
