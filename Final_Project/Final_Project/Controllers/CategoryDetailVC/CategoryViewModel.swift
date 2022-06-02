//
//  CategoryViewModel.swift
//  Final_Project
//
//  Created by tri.nguyen on 24/05/2022.
//

import Foundation

final class CategoryViewModel {
    
    // MARK: - Properties
    var news: [New] = []
    var categoryType: NewsViewModel.SectionType
    var page: Int = 1
    var pageSize: Int = 20

    // MARK: - Init
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
    
    func checkLoadMore(at indexPath: IndexPath) -> Bool {
        if indexPath.row == news.count - 1 {
            page += 1
            return true
        }
        return false
    }
}

// MARK: - API
extension CategoryViewModel {
    
    func loadAPI(completion: @escaping APICompletion) {
        let queryString = categoryType.title()
        NewsService.searchNewsCategory(keyword: queryString, page: page, pageSize: pageSize) { [weak self] result in
            guard let this = self else {
                completion(.failure(Api.Error.instanceRelease))
                return
            }
            switch result {
            case .success(let news):
                this.news += news
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
