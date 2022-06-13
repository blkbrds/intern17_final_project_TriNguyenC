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
        fetchAPIRealm()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        fetchAPIRealm()
//    }

//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
        /// Clear all data
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//    }
    
    // MARK: - UI
    override func setupUI() {
        title = "My News"
        
        // register
        let nib = UINib(nibName: Identifer.mainCell.rawValue, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: Identifer.mainCell.rawValue)
        
        // delegate && datasource
        tableView.delegate = self
        tableView.dataSource = self
        
        // navigation bar
        let trashAllMyNewsBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteAll))
        navigationItem.rightBarButtonItem = trashAllMyNewsBarButtonItem
    }
    
    override func setupData() {
        viewModel.setupObseve()
        
        /// closure
        viewModel.completion = { [weak self] in
            guard let this = self else { return }
            this.fetchAPIRealm()
        }
//        viewModel.delegate = self
        
        /// Add notification cennter
//        NotificationCenter.default.addObserver(self, selector: #selector(reloadData(_:)), name: NSNotification.Name(rawValue: MyNewsViewModel.myNewNotification), object: nil)
    }
        
    // MARK: - Fetch Realm
    private func fetchAPIRealm() {
        hud.show()
        viewModel.fetchData(completion: { [weak self] (done) in
            hud.dismiss()
            guard let this = self else { return }
            if done {
                this.tableView.reloadData()
            } else {
                print("Error Of Object From Realm")
            }
        })
    }

    // MARK: - Objc
    @objc private func deleteAll() {
        // create the alert
        let alert = UIAlertController(title: "My News Of You", message: "Are you sure you want to delete all the articles ?", preferredStyle: UIAlertController.Style.alert)

        // add the actions
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: { _ in
            self.viewModel.deleteAll { [weak self] (done) in
                guard let this = self else { return }
                if done {
                    this.fetchAPIRealm()
                } else {
                    print("Error Of Object From Realm")
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

        // show the alert
        self.present(alert, animated: true, completion: nil)
    }

    /// NotificationCenter
//    @objc private func reloadData(_ notification: NSNotification) {
//        fetchAPIRealm()
//    }
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

//// MARK: - Implement MyNewsViewModelDelegate
//extension MyNewsViewController: MyNewsViewModelDelegate {
//
//    func viewModel(_ viewModel: MyNewsViewModel, needperformAction action: MyNewsViewModel.Action) {
//        fetchAPIRealm()
//    }
//}
