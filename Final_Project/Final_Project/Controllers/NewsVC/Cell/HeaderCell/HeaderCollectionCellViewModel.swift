//
//  HeaderCollectionViewModel.swift
//  Final_Project
//
//  Created by tri.nguyen on 20/05/2022.
//

import Foundation
import UIKit


final class HeaderCollectionCellViewModel {
    
    var new: New?
    
    init(new: New) {
        self.new = new
    }
        
    func getImageURL() -> URL? {
        let url = URL(string: new?.urlToImage ?? "")
        return url
    }

}
