//
//  SplashViewController.swift
//  Final_Project
//
//  Created by tri.nguyen on 04/06/2022.
//

import UIKit

final class SplashViewController: UIViewController {

    // MARK: - IBOutet
    @IBOutlet private weak var containerView: UIView!

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        beginAnimations()
    }

    // MARK: - Animate
    private func beginAnimations() {
        containerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            self.containerView.alpha = 1
        }, completion: { _ in
            sceneDelegate?.swapRoot(.top)
        })
    }
}
