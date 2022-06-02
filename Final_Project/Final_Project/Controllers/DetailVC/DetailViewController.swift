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
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var newsAcencyLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    var viewModel: DetailViewModel?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let viewModel = viewModel else { return }
        favoriteButton.tintColor = viewModel.isAddedRealm() ? .red : .gray
    }
    
    // MARK: - UI
    override func setupUI() {
        guard let viewModel = viewModel else { return }
        titleDetailLabel.text = viewModel.new.title
        authorLabel.text = "By \(viewModel.new.author)"
        contentLabel.text = viewModel.new.content
        dateLabel.text = viewModel.new.publishedAt
        newsAcencyLabel.text = viewModel.new.source?.name
        descriptionLabel.text = viewModel.new.descriptions
        thumbnailImageView.sd_setImage(with: viewModel.getImageURL(), placeholderImage: nil)
    }
    
    // MARK: - IBAction
    @IBAction private func favoriteTapTouchUpInside(_ sender: Any) {
        /// Check if not added Realm then add to Realm
        /// If alreay added Realm then remove from Realm
        guard let viewModel = viewModel else { return }
        let isAddedRealm = viewModel.isAddedRealm()
        favoriteButton.tintColor = isAddedRealm ? .gray : .red
        if isAddedRealm {
            viewModel.removeFromRealm()
        } else {
            viewModel.addToRealm()
        }
    }
}
