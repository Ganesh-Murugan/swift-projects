//
//  HeaderTableViewCell.swift
//  News
//
//  Created by zoho on 14/07/22.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var publishedAt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(_ article: Article?){
        source.text = article?.source?.name
        author.text = article?.author
        publishedAt.text = article?.publishedAt
    }

}
