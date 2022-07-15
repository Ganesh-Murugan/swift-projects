//
//  CollegeTableViewCell.swift
//  CollegeList
//
//  Created by zoho on 09/07/22.
//

import UIKit

class CollegeTableViewCell: UITableViewCell {

    private var collegeLabel : UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 0, width: 400, height: 60)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private var siteLinkLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 30, width: 400, height: 20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collegeLabel)
        //contentView.addSubview(siteLinkLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCellView(_ college: Colleges) {
        self.collegeLabel.text = college.name
        //self.siteLinkLabel.text = college.webPages?.first
    }

}
