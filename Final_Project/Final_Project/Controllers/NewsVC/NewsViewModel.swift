//
//  NewsViewModel.swift
//  Final_Project
//
//  Created by tri.nguyen on 18/05/2022.
//

import UIKit

final class NewsViewModel {
    
    // MARK: - Enum
    enum SectionType: Int {
        case general
        case health
        case sports
        case science
        case business
        case entertainment
        case technology
        
        func title() -> String {
            switch self {
            case .general:
                return "General"
            case .health:
                return "Health"
            case .sports:
                return "Sports"
            case .science:
                return "Science"
            case .business:
                return "Business"
            case .entertainment:
                return "Entertaiment"
            case .technology:
                return "Technology"
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
    
    func viewModelHeaderForCollectionCell(at indexPath: IndexPath) -> HeaderCollectionCellViewModel {
        let new = headlineNews[indexPath.row]
        return HeaderCollectionCellViewModel(new: new)
    }
    
    func viewModelForDetail(at indexPath: IndexPath) -> DetailViewModel {
        guard let type = NewsViewModel.SectionType(rawValue: indexPath.section),
              let news = data[type] else { return DetailViewModel(new: nil) }
        return DetailViewModel(new: news[indexPath.row])
    }
    
    func viewModelForDetailHeader(at indexPath: IndexPath) -> DetailViewModel {
        return DetailViewModel(new: headlineNews[indexPath.row])
    }
    
    func viewModelForSectionHeader(at section: Int) -> HeaderSectionViewModel {
        guard let type = SectionType(rawValue: section) else { return HeaderSectionViewModel(sectionType: .general)}
        return HeaderSectionViewModel(sectionType: type)
    }    
}

// MARK: - API
extension NewsViewModel {
    
    func loadAPI(type: SectionType, completion: @escaping Completion) {
        let queryString = type.title()
        NewsService.searchNews(keyword: queryString, pageSize: 4) { [weak self] searchNews in
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
