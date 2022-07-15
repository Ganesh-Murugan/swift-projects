//
//  ImageTableViewCell.swift
//  News
//
//  Created by zoho on 14/07/22.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var articleImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func configure(_ imgUrlString: String) {
        articleImageView.loadImage(imgUrlString)
    }
}

