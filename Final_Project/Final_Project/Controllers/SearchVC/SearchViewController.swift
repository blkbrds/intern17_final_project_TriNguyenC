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
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.reloadData()
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
        navigationItem.searchController = search

        // collection layout
        let flowLayout = LeftAlignedCollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 15
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        flowLayout.headerReferenceSize = CGSize(width: collectionView.frame.width, height: 40)
        collectionView.collectionViewLayout = flowLayout
    }
}

// MARK: - Extention UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tag = viewModel.getTitleForTopic(at: indexPath)
        let label = UILabel(frame: CGRect.zero)
        label.text = tag
        label.sizeToFit()
        return CGSize(width: label.bounds.size.width + 20, height: 45)
    }
}

// MARK: - Extention UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRow(in: section)
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
        let vc = SearchResultViewController()
        vc.viewModel.queryString = viewModel.getTitleForTopic(at: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extention UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let queryText = searchBar.text else { return }
        let searchResultVC = SearchResultViewController()
        searchResultVC.viewModel.queryString = queryText
        navigationController?.pushViewController(searchResultVC, animated: true)
    }
}
