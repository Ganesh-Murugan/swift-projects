//
//  plainCellTableViewCell.swift
//  CustomCellExample
//
//  Created by zoho on 16/06/22.
//

import UIKit

class SwitchCell: UITableViewCell, Cell {
    
    @IBOutlet weak var toggle: UISwitch!
    @IBOutlet weak var settingName: UILabel!
    @IBOutlet weak var settingDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
