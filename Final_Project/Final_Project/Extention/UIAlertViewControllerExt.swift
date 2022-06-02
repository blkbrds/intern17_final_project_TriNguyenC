//
//  UIAlertViewControllerExt.swift
//  Final_Project
//
//  Created by tri.nguyen on 25/05/2022.
//


import UIKit

extension UIAlertController {
    
    // MARK: - Alert
    class func showAlert(error: APIError, from vc: UIViewController) {
        let alertVC = UIAlertController(title: "Cancel", message: error.localizedDescription, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Check", style: .cancel, handler: nil))
        vc.present(alertVC, animated: true)
    }
}
