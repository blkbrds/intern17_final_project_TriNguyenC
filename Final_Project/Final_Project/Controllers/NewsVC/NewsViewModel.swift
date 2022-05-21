//
//  NewsViewModel.swift
//  Final_Project
//
//  Created by tri.nguyen on 18/05/2022.
//

import Foundation

final class NewsViewModel {
    
    // MARK: - Enum
    enum SectionType: Int {
        case health
        case sports
        case science
        
        func title() -> String {
            switch self {
            case .health:
                return "Health"
            case .sports:
                return "Sports"
            case .science:
                return "Science"
            }
        }
    }
    
    typealias Completion = (Bool, APIError?) -> Void
    
    // MARK: - Properties
    var data: [SectionType: [New]] = [:]
    var headlineNews: [New] = []

    // MARK: - Cell
    func viewModelForCell(at indexPath: IndexPath) -> MainCellViewModel {
        guard let type = NewsViewModel.SectionType(rawValue: indexPath.section),
              let news = data[type] else { return MainCellViewModel(new: nil) }
        return MainCellViewModel(new: news[indexPath.row])
    }
    
    func viewModelHeaderForCell(at indexPath: IndexPath) -> HeaderCollectionCellViewModel {
        let new = headlineNews[indexPath.row]
        return HeaderCollectionCellViewModel(new: new)
    }
}

// MARK: - API
extension NewsViewModel {

    func loadAPI(type: SectionType, completion: @escaping Completion) {
        let queryString = type.title()
        NewsService.searchNews(keyword: queryString) { [weak self] searchNews in
            guard let this = self else {
                completion(false, .error("URL is not valid"))
                return
            }
            if let news = searchNews {
                this.data[type] = news
                completion(true, nil)
            } else {
                completion(false, .error("Data is nil"))
            }
        }
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
