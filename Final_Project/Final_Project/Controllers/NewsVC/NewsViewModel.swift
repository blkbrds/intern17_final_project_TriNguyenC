//
//  NewsViewModel.swift
//  Final_Project
//
//  Created by tri.nguyen on 18/05/2022.
//

import UIKit

final class NewsViewModel {
    
    // MARK: - Enum
    enum SectionType: Int, CaseIterable {
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
              let news = data[type] else { return DetailViewModel(new: New()) }
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
    
    func loadAPI(type: SectionType, completion: @escaping APICompletion) {
        let queryString = type.title()
        
        NewsService.searchNews(keyword: queryString, pageSize: 5) { [weak self] result in
            guard let this = self else {
                completion(.failure(Api.Error.instanceRelease))
                return
            }
            switch result {
            case .success(let news):
                this.data[type] = news
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadAPIHeadlines(completion: @escaping APICompletion) {
        NewsService.getTopHeadlines(country: "us") { [weak self] result in
            guard let this = self else {
                completion(.failure(Api.Error.instanceRelease))
                return
            }
            switch result {
            case .success(let news):
                this.headlineNews = news
                completion(.success)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }    
}
