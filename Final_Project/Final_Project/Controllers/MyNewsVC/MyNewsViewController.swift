//
//  MyNewsViewController.swift
//  Final_Project
//
//  Created by tri.nguyen on 17/05/2022.
//

import UIKit

final class MyNewsViewController: BaseViewController {
    
    // MARK: - Enum
    enum Identifer: String {
        case mainCell = "MainTableViewCell"
    }

    // MARK: - Properties
    var viewModel = MyNewsViewModel()
    
    // MARK: - Outlet
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAPIRealm()
    }
    
    // MARK: - UI
    override func setupUI() {
        title = "My News"
        
        // register
        let nib = UINib(nibName: Identifer.mainCell.rawValue, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: Identifer.mainCell.rawValue)
        
        // delegate && datasource
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Fetch Realm
    private func fetchAPIRealm() {
        viewModel.fetchData(completion: { [weak self] (done) in
            guard let this = self else { return }
            if done {
                this.tableView.reloadData()
            } else {
                print("Error Of Object From Realm")
            }
        })
    }
}

// MARK: - Extention UITableViewDelegate
extension MyNewsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController()
        vc.viewModel = viewModel.viewModelForDetail(at: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extention UITableViewDataSource
extension MyNewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.myNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifer.mainCell.rawValue, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.viewModel = viewModel.viewModelForCell(at: indexPath)
        return cell
    }
}
