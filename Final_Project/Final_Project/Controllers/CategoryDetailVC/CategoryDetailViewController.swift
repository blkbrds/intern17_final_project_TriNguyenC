//
//  CategoryDetailViewController.swift
//  Final_Project
//
//  Created by tri.nguyen on 24/05/2022.
//

import UIKit

final class CategoryDetailViewController: BaseViewController {
    
    // MARK: - Enum
    enum Identifier: String {
        case mainCell = "MainTableViewCell"
    }
    
    // MARK: - Outlet
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: CategoryViewModel?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UI
    override func setupUI() {
        title = viewModel?.categoryType.title()
        configTableView()
    }
    
    private func configTableView() {
        let mainNib = UINib(nibName: Identifier.mainCell.rawValue, bundle: nil)
        tableView.register(mainNib, forCellReuseIdentifier: Identifier.mainCell.rawValue)
        
        // delegate && datasource
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Data
    override func setupData() {
        fetchAPI()
    }
    
    // MARK: - Fetch API
    private func fetchAPI() {
        viewModel?.loadAPI(completion: { [weak self] isSuccess, error in
            guard let this = self else { return }
            if isSuccess {
                this.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        })
    }
}

// MARK: - Extention UITableViewDelegate
extension CategoryDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.mainCell.rawValue, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.viewModel = viewModel?.viewModelForCell(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewModel = viewModel else { return }
        let vc = DetailViewController()
        vc.viewModel = viewModel.viewModelForDetail(at: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extention UITableViewDataSource
extension CategoryDetailViewController: UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return CategoryViewModel.SectionType(rawValue: section)?.title()
//    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.news.count ?? 0
    }
}
