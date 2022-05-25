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
        case mainCell = "MainTableViewCell"
        case headerCell = "HeaderCollectionViewCell"
    }
    
    // MARK: - Properties
    private var viewModel = NewsViewModel()
    
    // MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - UI
    override func setupUI() {
        // title
        title = "Top Stories"
        configCollectionView()
        configTableView()
    }
    
    // MARK: - ConfigViews
    private func configTableView() {
        let mainNib = UINib(nibName: Identifier.mainCell.rawValue, bundle: nil)
        tableView.register(mainNib, forCellReuseIdentifier: Identifier.mainCell.rawValue)
        
        // delegate && datasource
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configCollectionView() {
        let headerNib = UINib(nibName: Identifier.headerCell.rawValue, bundle: nil)
        collectionView.register(headerNib, forCellWithReuseIdentifier: Identifier.headerCell.rawValue)
        
        // delegate && datasource
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Data
    override func setupData() {
        fetchAPI()
    }
    
    // MARK: - Fetch Data
    private func fetchAPI() {
        let distchPathGroup = DispatchGroup()
        
        // Call Healine API
        distchPathGroup.enter()
        viewModel.loadAPIHeadlines { isSucess, error in
            distchPathGroup.leave()
        }
        
        // Call Section API
        distchPathGroup.enter()
        viewModel.loadAPI(type: .general) { isSuccess, error in
            distchPathGroup.leave()
        }
        
        distchPathGroup.enter()
        viewModel.loadAPI(type: .health) { isSuccess, error in
            distchPathGroup.leave()
        }
        
        distchPathGroup.enter()
        viewModel.loadAPI(type: .sports) { isSuccess, error in
            distchPathGroup.leave()
        }
        
        distchPathGroup.enter()
        viewModel.loadAPI(type: .science) { isSuccess, error in
            distchPathGroup.leave()
        }
        
        distchPathGroup.enter()
        viewModel.loadAPI(type: .business) { isSucess, error in
            distchPathGroup.leave()
        }
        
        distchPathGroup.enter()
        viewModel.loadAPI(type: .entertainment) { isSucess, error in
            distchPathGroup.leave()
        }
        
        distchPathGroup.enter()
        viewModel.loadAPI(type: .technology) { isSucess, error in
            distchPathGroup.leave()
        }
        
        distchPathGroup.notify(queue: .main, execute: { [weak self] in
            guard let this = self else { return }
            this.collectionView.reloadData()
            this.tableView.reloadData()
        })
    }
}

// MARK: - Extention UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.mainCell.rawValue, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.viewModel = viewModel.viewModelForCell(at: indexPath)
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerSectionView = Bundle.main.loadNibNamed("HeaderSectionView", owner: self, options: nil)?.first as? HeaderSectionView
        headerSectionView?.delegate = self
        headerSectionView?.viewModel = viewModel.viewModelForSectionHeader(at: section)
        return headerSectionView
    }
}

// MARK: - Extention UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NewsViewModel.SectionType(rawValue: section)?.title()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let type = NewsViewModel.SectionType(rawValue: section),
              let news = viewModel.data[type]?.count else { return 0 }
        return news
    }
}

// MARK: - Extention UICollectionViewDelegateFlowLayout
extension NewsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 300)
    }
}

// MARK: - Extention UICollectionViewDataSource
extension NewsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.headlineNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.headerCell.rawValue, for: indexPath) as? HeaderCollectionViewCell else { return UICollectionViewCell() }
        cell.viewModel = viewModel.viewModelHeaderForCollectionCell(at: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.viewModel = viewModel.viewModelForDetailHeader(at: indexPath)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Implement HeaderViewDelegate
extension NewsViewController: HeaderSectionViewDelegate {
    
    func view(view: HeaderSectionView, needsPerform action: HeaderSectionView.Action) {
        switch action {
        case .tap(let sectionType):
            let vc = CategoryDetailViewController()
            let viewModel = CategoryViewModel(categoryType: sectionType)
            vc.viewModel = viewModel
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
