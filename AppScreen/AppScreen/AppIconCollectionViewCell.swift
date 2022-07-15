//
//  AppIconCollectionViewCell.swift
//  AppScreen
//
//  Created by zoho on 21/06/22.
//

import UIKit

class AppIconCollectionViewCell: UICollectionViewCell {
    private var iconView: UIView = {
        var iconView = UIView()
        iconView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        iconView.layer.cornerRadius = 4
        iconView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        return iconView
    }()
    private var icon: UIImageView = {
       var icon = UIImageView()
        icon.image = UIImage(named: "icons8-settings-48.png")
        icon.frame = CGRect(x: 10, y: 0, width: 50, height: 50)
        return icon
    }()
    private var iconLabel: UILabel = {
        var label = UILabel()
        label.frame = CGRect(x: 0, y: 55, width: 70, height: 15)
        label.setFont(.caption)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    override init(frame: CGRect){
        super.init(frame: frame)
        iconView.addSubview(icon)
        iconView.addSubview(iconLabel)
        contentView.addSubview(iconView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func add(_ app: String){
        self.iconLabel.text = app
    }
}
