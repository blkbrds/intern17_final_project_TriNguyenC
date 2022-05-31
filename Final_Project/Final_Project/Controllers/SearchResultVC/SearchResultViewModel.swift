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
    
    // MARK: - Load API
    func loadAPI(completion: @escaping APICompletion) {
        NewsService.searchNews(keyword: queryString, pageSize: 8) { [weak self] result in
            guard let this = self else {
                completion(.failure(Api.Error.instanceRelease))
                return
            }
            switch result {
            case .success(let news):
                this.resultNews = news
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
