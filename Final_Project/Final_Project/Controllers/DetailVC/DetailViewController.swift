//
//  DetailViewController.swift
//  Final_Project
//
//  Created by tri.nguyen on 17/05/2022.
//

import UIKit
import SDWebImage

final class DetailViewController: BaseViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var titleDetailLabel: UILabel!
    @IBOutlet private weak var newsAcencyLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    // MARK: - Properties
    var viewModel = DetailViewModel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        titleDetailLabel.text = viewModel.new?.title
        authorLabel.text = viewModel.new?.author
        contentLabel.text = viewModel.new?.content
        dateLabel.text = viewModel.new?.publishedAt
        newsAcencyLabel.text = viewModel.new?.source?.name
        descriptionLabel.text = viewModel.new?.description
        thumbnailImageView.sd_setImage(with: viewModel.getImageURL(), placeholderImage: nil)
    }
}
