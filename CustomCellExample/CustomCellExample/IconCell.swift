//
//  LabelWithIconCell.swift
//  CustomCellExample
//
//  Created by zoho on 16/06/22.
//

import UIKit
protocol Cell {
    var settingName: UILabel! { get }
    var settingDescription: UILabel! { get }
}
class IconCell: UITableViewCell, Cell {

    @IBOutlet weak var settingName: UILabel!
    @IBOutlet weak var settingDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    func addCell(_ index: Settings) {
//        self.settingName.text = index.settingName
//        self.settingDescription.text = index.settingDescription
//    }
   
}

