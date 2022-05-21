//
//  MainTableViewCell.swift
//  Final_Project
//
//  Created by tri.nguyen on 17/05/2022.
//

import UIKit
import SDWebImage

final class MainTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var mainImageView: UIImageView!
    @IBOutlet private weak var mainTitleLabel: UILabel!
    @IBOutlet private weak var publishedAtLabel: UILabel!
    
    // MARK: - Properties
    var viewModel: MainCellViewModel? {
        didSet {
            updateUIView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: UI
    private func updateUIView() {
        guard let viewModel = viewModel else { return }
        mainTitleLabel.text = viewModel.new?.title
        publishedAtLabel.text = viewModel.new?.publishedAt
        mainImageView.sd_setImage(with: viewModel.getImageURL(), placeholderImage: nil)

//        viewModel.loadImage(completion: { [weak self] in
//            guard let this = self, let imageData = viewModel.imageData else { return }
//            let image = UIImage(data: imageData)
//            this.mainImageView.image = image
//        })
    }
}
