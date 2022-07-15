//
//  SwitchCell.swift
//  SettingScreen
//
//  Created by zoho on 16/06/22.
//

import UIKit

class SwitchCell: UITableViewCell, Cell {
    var settingName = UILabel()
    var settingDescription = UILabel()
    var toggle = UISwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
        contentView.frame.size.width = UIScreen.main.bounds.width
        
        contentView.addSubview(settingName)
        contentView.addSubview(settingDescription)
        contentView.addSubview(toggle)
        settingName.setFont(.body)
        settingDescription.setFont(.caption)
        addFrame()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    func addFrame() {
        toggle.frame = CGRect(x: contentView.bounds.width-70, y: contentView.bounds.height/2, width: 10, height: 10)
        settingName.frame = CGRect(x: 15, y: contentView.bounds.height - 15, width: contentView.bounds.width, height: 20)
        settingDescription.frame = CGRect(x: 15, y: 45, width: contentView.bounds.width - 50, height: 55)
    }
    
    func toggled(_ toggle: Bool) {
        self.toggle.setOn(toggle, animated: true)
    }
    func setConstraints(){
        
        
    }
}


//        settingName.setupContraints(width: 140, height: 0, topAnchor: contentView.topAnchor, topConstant: 15, leadingAnchor: contentView.leadingAnchor, leadingConstant: 10)
//        settingDescription.setupContraints(width: contentView.bounds.width - 60, height: 0, topAnchor: settingName.bottomAnchor, topConstant: 15, bottomConstant: 0, leadingAnchor: contentView.leadingAnchor, leadingConstant: 10, trailingConstant: 0)
//        toggle.setupContraints(width: 30, height: 30, topAnchor: contentView.topAnchor, topConstant: contentView.bounds.height/2, trailingAnchor: contentView.trailingAnchor, trailingConstant: -40)


//extension SwitchCell {
//    func setNameConstraints() {
//        settingName.initialLabelSetup()
//        settingName.body()
//        settingName.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -15).isActive = true
//        settingName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
//        settingName.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        settingName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
//    }
//    func setDescriptionConstraints() {
//        settingDescription.initialLabelSetup()
//        settingDescription.caption()
//        settingDescription.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 15).isActive = true
//        settingDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
//        settingDescription.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        settingDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
//    }
    
//    func setIconConstraints(){
//        toggle.translatesAutoresizingMaskIntoConstraints = false
//        toggle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        toggle.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 170).isActive = true
//    }
//}
