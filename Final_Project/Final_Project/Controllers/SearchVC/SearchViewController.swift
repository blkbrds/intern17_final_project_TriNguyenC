//
//  SearchViewController.swift
//  Final_Project
//
//  Created by tri.nguyen on 17/05/2022.
//

import UIKit
import Alamofire

final class SearchViewController: BaseViewController {
    
    // MARK: - Enum
    enum Identifier: String {
        case moreTopicCell = "MoreTopicCollectionViewCell"
        case headerSeach = "HeaderSearchSectionCollectionReusableView"
    }
    
    // MARK: - Properties
    private var viewModel = SearchViewModel()
    
    // MARK: - Outlet
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var fadeView: UIView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAPISearchRealm()
    }
    
    // MARK: - UI
    override func setupUI() {
        title = "Search"
        
        // register
        let moreTopicNib = UINib(nibName: Identifier.moreTopicCell.rawValue, bundle: .main)
        collectionView.register(moreTopicNib, forCellWithReuseIdentifier: Identifier.moreTopicCell.rawValue)
        
        let headerNib = UINib(nibName: Identifier.headerSeach.rawValue, bundle: .main)
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Identifier.headerSeach.rawValue)
                        
        // delegate && datasource
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // search controller
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.delegate = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search topics", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        search.searchBar.searchTextField.leftView?.tintColor = .white
        search.searchBar.barStyle = .black
        search.searchBar.setImage(UIImage(systemName: "xmark.circle.fill"), for: .clear, state: .normal)
        navigationItem.searchController = search

        // collection layout
        let flowLayout = LeftAlignedCollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 15
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        flowLayout.headerReferenceSize = CGSize(width: collectionView.frame.width, height: 40)
        collectionView.collectionViewLayout = flowLayout
    }

    // MARK: - Fetch Realm
    private func fetchAPISearchRealm() {
        hud.show()
        viewModel.fetchData(completion: { [weak self] (done) in
            hud.dismiss()
            guard let this = self else { return }
            if done {
                this.collectionView.reloadData()
            } else {
                print("Error Of Object From Realm")
            }
        })
    }

    // MARK: - Private Function
    private func handlePushToSearchResult(_ searchResultVM: SearchResultViewModel, needSaveHistory: Bool = false) {
        let searchResultVC = SearchResultViewController()
        searchResultVC.bind(viewModel: searchResultVM)
        if needSaveHistory {
            viewModel.saveKeyword(searchResultVM.queryString)
        }
        navigationController?.pushViewController(searchResultVC, animated: true)
    }
}

// MARK: - Extention UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionType = SearchSection.allCases[indexPath.section]
        let titleString = viewModel.getTitle(at: indexPath.item, by: sectionType)
        let maskLabel = UILabel(frame: .zero)
        maskLabel.text = titleString
        maskLabel.sizeToFit()
        let verticalSpacing: CGFloat = 10
        
        let labelWidth = maskLabel.bounds.width + (verticalSpacing * 2)
        let labelHeight: CGFloat = 45
        return CGSize(width: labelWidth, height: labelHeight)
//        let tag = viewModel.getTitleForTopic(at: indexPath)
//        let label = UILabel(frame: CGRect.zero)
//        label.text = tag
//        label.sizeToFit()
//        return CGSize(width: label.bounds.size.width + 20, height: 45)
    }
}

// MARK: - Extention UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return viewModel.numberOfSections()
        return SearchSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = SearchSection.allCases[section]
        return viewModel.getNumberItemOfSections(at: section, by: sectionType)
//        return viewModel.numberOfRow(in: section)
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.moreTopicCell.rawValue, for: indexPath) as? MoreTopicCollectionViewCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel.viewForMoreTopicCollectionCell(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Identifier.headerSeach.rawValue, for: indexPath) as? HeaderSearchSectionCollectionReusableView {
                header.headerSearchLabel.text = viewModel.getTitleHeader(at: indexPath)
                return header
            }
        default:
            break
        }
        return UICollectionReusableView()
    }
}

// MARK: - Extention UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = SearchSection.allCases[indexPath.section]
        let keywordString = viewModel.getTitle(at: indexPath.item, by: sectionType)
        let searchResultVM = SearchResultViewModel(queryString: keywordString)
        handlePushToSearchResult(searchResultVM)
    }
}

// MARK: - Extention UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let queryText = searchBar.text else { return }
        let searchResultVM = SearchResultViewModel(queryString: queryText)
        handlePushToSearchResult(searchResultVM, needSaveHistory: true)
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        fadeView.bringSubviewToFront(collectionView)
        fadeView.alpha = 0
        UIView.animate(withDuration: 0.6) {
            self.fadeView.alpha = 0.4
        }
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        collectionView.bringSubviewToFront(fadeView)
        UIView.animate(withDuration: 0.6) {
            self.fadeView.alpha = 0
        }
        return true
    }
}
