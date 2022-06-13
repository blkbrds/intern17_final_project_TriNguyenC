//
//  SearchResultViewModel.swift
//  Final_Project
//
//  Created by tri.nguyen on 30/05/2022.
//

import Foundation

final class SearchResultViewModel {
    
    // MARK: - Properties
    var queryString: String = ""
    private(set) var resultNews: [New] = []
    var page: Int = 1
    var pageSize: Int = 20

    // MARK: Init
    init(queryString: String) {
        self.queryString = queryString
    }
        
    // MARK: - Cell
    func viewModelSearchForCell(at indexPath: IndexPath) -> MainCellViewModel {
        return MainCellViewModel(new: resultNews[indexPath.row])
    }
    
    func viewModelForDetail(at indexPath: IndexPath) -> DetailViewModel {
        return DetailViewModel(new: resultNews[indexPath.row])
    }
    
    // MARK: - Load More
    func checkLoadMoreSearch(at indexPath: IndexPath) -> Bool {
        if indexPath.row == resultNews.count - 1 {
            page += 1
            return true
        }
        return false
    }
    
    // MARK: - Load API
    func loadAPI(completion: @escaping APICompletion) {
        NewsService.searchNewsCategory(keyword: queryString, page: page, pageSize: pageSize) { [weak self] result in
            guard let this = self else {
                completion(.failure(Api.Error.instanceRelease))
                return
            }
            switch result {
            case .success(let news):
                this.resultNews += news
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
