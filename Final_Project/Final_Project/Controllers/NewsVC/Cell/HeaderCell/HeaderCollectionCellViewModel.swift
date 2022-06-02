//
//  HeaderCollectionViewModel.swift
//  Final_Project
//
//  Created by tri.nguyen on 20/05/2022.
//

import Foundation
import UIKit


final class HeaderCollectionCellViewModel {
    
    // MARK: - Properties
    var new: New?
    
    // MARK: - Init
    init(new: New) {
        self.new = new
    }
        
    // MARK: - GetImage
    func getImageURL() -> URL? {
        let url = URL(string: new?.urlToImage ?? "")
        return url
    }
}
