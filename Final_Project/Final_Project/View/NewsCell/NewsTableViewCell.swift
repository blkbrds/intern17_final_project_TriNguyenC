//
//  NewsTableViewCell.swift
//  Final_Project
//
//  Created by tri.nguyen on 17/05/2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
