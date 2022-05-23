//
//  DetailViewModel.swift
//  Final_Project
//
//  Created by tri.nguyen on 23/05/2022.
//

import Foundation

final class DetailViewModel {
 
    // MARK: - Properties
    var new: New?
    
    init(new: New?) {
        self.new = new
    }
    
    init() {}
        
    func getImageURL() -> URL? {
        let url = URL(string: new?.urlToImage ?? "")
        return url
    }
}
