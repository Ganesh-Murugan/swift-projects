//
//  ContentTableViewCell.swift
//  News
//
//  Created by zoho on 14/07/22.
//

import UIKit

class ContentTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configure(_ article: Article?) {
        title.text = article?.title
        content.text = article?.description
    }
}
