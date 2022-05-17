//
//  NewsViewController.swift
//  Final_Project
//
//  Created by tri.nguyen on 17/05/2022.
//

import UIKit

final class NewsViewController: BaseViewController {
    
    // MARK: - Enum
    enum Identifier: String {
        case newsCell = "NewsTableViewCell"
        case mainCell = "MainTableViewCell"
    }
    
    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - UI
    override func setupUI() {
        // title
        title = "New Stories"
        
        // navigation bar
        configNavigationBar()
                
        // register
        let newsNib = UINib(nibName: Identifier.newsCell.rawValue, bundle: .main)
        tableView.register(newsNib, forCellReuseIdentifier: Identifier.newsCell.rawValue)
        
        let mainNib = UINib(nibName: Identifier.mainCell.rawValue, bundle: .main)
        tableView.register(mainNib, forCellReuseIdentifier: Identifier.mainCell.rawValue)
        
        // delegate && datasource
        tableView.delegate = self
        tableView.dataSource = self
    }
        
    // MARK: - Config NavigationBar
    private func configNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .red
        
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            navigationController!.navigationBar.compactScrollEdgeAppearance = appearance
        }
    }
}

// MARK: - Extention UITableViewDelegate && UITableViewDataSource
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.newsCell.rawValue, for: indexPath) as? NewsTableViewCell ?? UITableViewCell()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.mainCell.rawValue, for: indexPath) as? MainTableViewCell ?? UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 250
        } else {
            return 150
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

