//
//  HeaderView.swift
//  Final_Project
//
//  Created by tri.nguyen on 24/05/2022.
//

import UIKit

// MARK: - Protocol
protocol HeaderSectionViewDelegate: class {
    func view(view: HeaderSectionView, needsPerform action: HeaderSectionView.Action)
}

final class HeaderSectionView: UIView {
    
    // MARK: - Enum
    enum Action {
        case tap(sectionType: NewsViewModel.SectionType)
    }
    
    // MARK: - Properties
    var viewModel: HeaderSectionViewModel? {
        didSet {
            updateUI()
        }
    }
    
    weak var delegate: HeaderSectionViewDelegate?
    
    // MARK: - Outlet
    @IBOutlet private weak var sectionLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Action
    @IBAction private func seeMoreButtonTouchUpInside(_ sender: UIButton) {
        guard let sectionType = viewModel?.sectionType else { return }
        delegate?.view(view: self, needsPerform: .tap(sectionType: sectionType))
    }
    
    // MARK: - UI
    private func updateUI() {
        sectionLabel.text = viewModel?.sectionType.title()
    }
}
