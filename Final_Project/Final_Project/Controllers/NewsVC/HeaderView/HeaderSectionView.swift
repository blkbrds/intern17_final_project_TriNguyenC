//
//  HeaderView.swift
//  Final_Project
//
//  Created by tri.nguyen on 24/05/2022.
//

import UIKit

// MARK: - Protocol
protocol HeaderSectionViewDelegate: AnyObject {
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
    @IBOutlet private weak var seemoreSectionButton: UIButton!
    
    
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
        let fullString = "\(viewModel?.sectionType.title() ?? "")  >"
        
        let range = (fullString as NSString).range(of: ">")
        let mutableAttributedString = NSMutableAttributedString.init(string: fullString)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range)

        seemoreSectionButton.setAttributedTitle(mutableAttributedString, for: .normal)
        seemoreSectionButton.titleLabel?.font = UIFont(name: "Helvetica", size: 24)
    }
}
