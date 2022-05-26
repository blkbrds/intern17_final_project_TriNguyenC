//
//  TopicTableViewCell.swift
//  Final_Project
//
//  Created by tri.nguyen on 26/05/2022.
//

import UIKit

final class HistoryTableViewCell: UITableViewCell {

    // MARK: - Enum
    enum Identifier: String {
        case topicHistoryCell = "HistoryCollectionViewCell"
    }
        
    // MARK: - IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - ConfigCollectionView
    private func configCollectionView() {
        // register
        let nib = UINib(nibName: Identifier.topicHistoryCell.rawValue, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: Identifier.topicHistoryCell.rawValue)
        
        // delegate && datasource
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - UICollectionViewDataSource
extension HistoryTableViewCell: UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.topicHistoryCell.rawValue, for: indexPath) as? HistoryCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HistoryTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UICollectionViewFlowLayout.automaticSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

