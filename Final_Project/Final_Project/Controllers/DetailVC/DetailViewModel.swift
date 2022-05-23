//
//  DetailViewModel.swift
//  Final_Project
//
//  Created by tri.nguyen on 23/05/2022.
//

import Foundation

final class DetailViewModel {
    
    // MARK: - Properties
    var headlineNews: [New] = []
    
    typealias Completion = (Bool, APIError?) -> Void

    func viewModelHeaderForCell(at indexPath: IndexPath) -> HeaderCollectionCellViewModel {
        let new = headlineNews[indexPath.row]
        return HeaderCollectionCellViewModel(new: new)
    }

    func loadAPIHeadlines(compeltion: @escaping Completion) {
        NewsService.getTopHeadlines(country: "us") { [weak self] headlineNews in
            guard let this = self else {
                compeltion(false, .error("URL is not valid"))
                return
            }
            if let headlineNews = headlineNews {
                this.headlineNews = headlineNews
                compeltion(true, nil)
            } else {
                compeltion(false, .error("Data is nil"))
            }
        }
    }
}
