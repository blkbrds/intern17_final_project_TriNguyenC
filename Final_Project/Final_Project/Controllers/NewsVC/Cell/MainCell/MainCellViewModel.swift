//
//  MainCellViewModel.swift
//  Final_Project
//
//  Created by tri.nguyen on 18/05/2022.
//

import Foundation
import UIKit

final class MainCellViewModel {
    
    // MARK: - Properties
    var new: New?
    var imageData: Data? // Save image
    
    // MARK: - Init
    init(new: New?) {
        self.new = new
    }
    
    // MARK: - LoadImage
//    func loadImage(completion: @escaping () -> Void) {
//        PhotoManager.shared.downloadImage(with: new?.urlToImage ?? "") { [weak self] data in
//            guard let this = self else { return }
//            this.imageData = data
//            completion()
//        }
//    }

    // MARK: - GetImage
    func getImageURL() -> URL? {
        let url = URL(string: new?.urlToImage ?? "")
        return url
    }
}
