//
//  SearchResultViewController.swift
//  Final_Project
//
//  Created by tri.nguyen on 30/05/2022.
//

import UIKit

class SearchResultViewController: BaseViewController {

    // MARK: - Enum
    enum Identifier: String {
        case mainCell = "MainTableViewCell"
    }
    
    // MARK: - Outlet
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    private var viewModel = SearchResultViewModel(queryString: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupUI() {
        title = viewModel.queryString
        configTableView()
    }

    func bind(viewModel: SearchResultViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Config
    private func configTableView() {
        // register
        let mainNib = UINib(nibName: Identifier.mainCell.rawValue, bundle: nil)
        tableView.register(mainNib, forCellReuseIdentifier: Identifier.mainCell.rawValue)
        
        // delegate && datasource
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func setupData() {
        loadResultSearchAPI()
    }
    
    // MARK: - Load API
    private func loadResultSearchAPI() {
        hud.show()
        viewModel.loadAPI { [weak self] result in
            hud.dismiss()
            guard let this = self else { return }
            switch result {
            case .success: this.tableView.reloadData()
            case .failure(let error):
                this.alert(title: "Error", msg: error.localizedDescription, handler: nil)
            }
        }
    }
}

// MARK: - Extention UITableViewDelegate
extension SearchResultViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.mainCell.rawValue, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.viewModel = viewModel.viewModelSearchForCell(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController()
        vc.viewModel = viewModel.viewModelForDetail(at: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let isLoadMore = viewModel.checkLoadMoreSearch(at: indexPath)
        if isLoadMore { loadResultSearchAPI() }
    }
}

// MARK: - Extention UITableViewDataSource
extension SearchResultViewController: UITableViewDataSource {
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.resultNews.count
    }
}
