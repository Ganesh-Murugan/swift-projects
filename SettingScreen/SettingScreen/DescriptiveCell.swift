//
//  DescriptiveCell.swift
//  SettingScreen
//
//  Created by zoho on 17/06/22.
//

import UIKit

class DescriptiveCell: UITableViewCell, Cell {
    var settingName = UILabel()
    var settingDescription = UILabel()
    var iconView = UIImageView(image: UIImage(named:"info"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addFrame(contentView.bounds.width, contentView.bounds.height)
        contentView.addSubview(settingName)
        contentView.addSubview(settingDescription)
        contentView.addSubview(iconView)
        settingName.setFont(.body)
        settingDescription.setFont(.caption)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addFrame(_ contentWidth: CGFloat, _ contentHeight: CGFloat) {
        settingName.frame = CGRect(x: 35, y: contentHeight/2.8, width: contentWidth, height: 20)
        settingDescription.frame = CGRect(x: 35, y: contentHeight, width: contentWidth, height: 15)
        iconView.frame = CGRect(x: 8, y: contentHeight/2, width: 20, height: 20)
    }


}
