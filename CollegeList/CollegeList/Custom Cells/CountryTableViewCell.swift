//
//  CountryTableViewCell.swift
//  CollegeList
//
//  Created by zoho on 02/07/22.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    private var countryLabel : UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 10, width: 400, height: 20)
        return label
    }()
    
    private var regionLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 35, width: 400, height: 20)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(regionLabel)
        contentView.addSubview(countryLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCellView(_ country: Countries) {
        self.countryLabel.text = country.country?.customTrim()
        self.regionLabel.text = "region: " + country.region.unwrap
    }
}

