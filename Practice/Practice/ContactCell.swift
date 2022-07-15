//
//  ContactCell.swift
//  Practice
//
//  Created by zoho on 10/06/22.
//

import UIKit

class ContactCell: UITableViewCell {
    @IBOutlet var name : UILabel?
    @IBOutlet var number : UILabel?
    @IBOutlet var emailId: UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print(contentView.bounds.width)
            
    }
    func add(_ index: Contact)  {
        name?.text = index.name
        number?.text = index.number?.toString
        emailId?.text = index.emailId
    }
    
}
