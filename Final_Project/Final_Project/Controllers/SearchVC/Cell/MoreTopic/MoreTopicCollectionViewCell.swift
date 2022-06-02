//
//  MoreTopicCollectionViewCell.swift
//  Final_Project
//
//  Created by tri.nguyen on 29/05/2022.
//

import UIKit

final class MoreTopicCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlet
    @IBOutlet private weak var topicLabel: UILabel!
    
    // MARK: - Properties
    var viewModel: MoreTopicCollectionCellViewModel? {
        didSet {
            configMoreTopicViewCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        topicLabel.layer.borderColor = UIColor.lightGray.cgColor
        topicLabel.layer.borderWidth = 0.5
    }
    
    // MARK: - Private
    private func configMoreTopicViewCell() {
        guard let viewModel = viewModel else { return }
        topicLabel.text = viewModel.title
    }
}
