//
//  HeaderCollectionViewCell.swift
//  Final_Project
//
//  Created by tri.nguyen on 20/05/2022.
//

import UIKit
import SDWebImage

final class HeaderCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    var viewModel: HeaderCollectionCellViewModel? {
        didSet {
            updateHeaderView()
        }
    }
    
    // MARK: - Outlet
    @IBOutlet private weak var headerImageView: UIImageView!
    @IBOutlet private weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: UI
    private func updateHeaderView() {
        guard let viewModel = viewModel else { return }
        headerLabel.text = viewModel.new?.title
        headerImageView.sd_setImage(with: viewModel.getImageURL(), placeholderImage: nil)
    }
}
