//
//  DetailViewController.swift
//  Final_Project
//
//  Created by tri.nguyen on 17/05/2022.
//

import UIKit

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
    private var viewModel = DetailViewModel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupData() {
        
    }
}
