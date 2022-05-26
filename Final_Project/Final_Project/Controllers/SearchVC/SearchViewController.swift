//
//  SearchViewController.swift
//  Final_Project
//
//  Created by tri.nguyen on 17/05/2022.
//

import UIKit

class SearchViewController: BaseViewController {
    
    // MARK: - Enum
    enum Identifier: String {
        case topicCell = "HistoryTableViewCell"
    }
    
    // MARK: - Outlets
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UI
    override func setupUI() {
        title = "Search"
        
        // register
        let nib = UINib(nibName: Identifier.topicCell.rawValue, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: Identifier.topicCell.rawValue)
        
        // delegate && datasource
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - Extention UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.topicCell.rawValue, for: indexPath) as? HistoryTableViewCell else { return UITableViewCell() }
        return cell
    }
}

// MARK: - Extention
extension SearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
