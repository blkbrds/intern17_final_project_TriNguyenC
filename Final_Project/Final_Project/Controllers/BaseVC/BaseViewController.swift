//
//  BaseViewController.swift
//  Final_Project
//
//  Created by tri.nguyen on 17/05/2022.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    // MARK: - Public Function
    func setupUI() {}
    func setupData() {}
}
