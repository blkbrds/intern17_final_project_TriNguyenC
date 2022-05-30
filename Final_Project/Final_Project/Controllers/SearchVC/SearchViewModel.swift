//
//  SearchViewModel.swift
//  Final_Project
//
//  Created by tri.nguyen on 28/05/2022.
//

import Foundation

final class SearchViewModel {
    
    // MARK: - Enum
    enum SearchSection: Int, CaseIterable {
        case base
        case around
        case more
        
        var title: String {
            switch self {
            case .base:
                return "Base on What You've Read"
            case .around:
                return "Around the BBC"
            case .more:
                return "More Topic"
            }
        }
    }
    
    var data : [SearchSection: [String]] = [.base: Config.baseTopic,
                                            .around: Config.aroundTopic,
                                            .more: Config.moreTopic]
    
    func viewForMoreTopicCollectionCell(at indexPath: IndexPath) -> MoreTopicCollectionCellViewModel {
        guard let sectionType = SearchSection(rawValue: indexPath.section),
              let topics = data[sectionType] else { return MoreTopicCollectionCellViewModel() }
        return MoreTopicCollectionCellViewModel(title: topics[indexPath.row])
    }
    
    func numberOfSections() -> Int {
        return data.count
    }
    
    func numberOfRow(in section: Int) -> Int {
        guard let sectionType = SearchSection(rawValue: section), let topics = data[sectionType] else { return 0 }
        return topics.count
    }

    func getTitleForTopic(at indexPath: IndexPath) -> String {
        guard let sectionType = SearchSection(rawValue: indexPath.section),
              let topics = data[sectionType] else { return "" }
        return topics[indexPath.row]
    }

    func getTitleHeader(at indexPath: IndexPath) -> String {
        let type = SearchSection(rawValue: indexPath.section)
        return type?.title ?? ""
    }
}

extension SearchViewModel {

    struct Config {
        static var baseTopic: [String] = ["Sport", "US & Canada", "Afica", "BBC Future", "BBC Worklife", "Latin America & Caribbean"]
        static var aroundTopic: [String] = ["BBC Culuters", "BBC Travel"]
        static var moreTopic: [String] = ["General", "Europe", "Sports", "Business", "Middle East" , "Health", "Education", "Stories", "Football", "World", "Formula 1", "Cricket", "Science", "Paradise Papers", "Asia", "Tennis", "Golf", "Athletics", "Cycling", "Middle East", "Tech", "UK", "Rugby Union", "Entertainment"]
    }
}
