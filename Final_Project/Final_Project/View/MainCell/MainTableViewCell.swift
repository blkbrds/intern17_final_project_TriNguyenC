//
//  MainTableViewCell.swift
//  Final_Project
//
//  Created by tri.nguyen on 17/05/2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
