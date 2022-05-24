//
//  CategoryViewModel.swift
//  Final_Project
//
//  Created by tri.nguyen on 24/05/2022.
//

import Foundation

final class CategoryViewModel {

    typealias Completion = (Bool, APIError?) -> Void
    
    // MARK: - Properties
    var news: [New] = []
    var categoryType: NewsViewModel.SectionType
    
    init(categoryType: NewsViewModel.SectionType) {
        self.categoryType = categoryType
    }
    
    // MARK: - Cell
    func viewModelForCell(at indexPath: IndexPath) -> MainCellViewModel {
        return MainCellViewModel(new: news[indexPath.row])
    }
        
    func viewModelForDetail(at indexPath: IndexPath) -> DetailViewModel {
        return DetailViewModel(new: news[indexPath.row])
    }
}

// MARK: - API
extension CategoryViewModel {
    
    func loadAPI(completion: @escaping Completion) {
        let queryString = categoryType.title()
        NewsService.searchNewsCategory(keyword: queryString) { [weak self] searchNews in
            guard let this = self else {
                completion(false, .error("URL is not valid"))
                return
            }
            if let news = searchNews {
                this.news = news
                completion(true, nil)
            } else {
                completion(false, .error("Data is nil"))
            }
        }
    }
}
