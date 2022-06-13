//
//  SearchViewModel.swift
//  Final_Project
//
//  Created by tri.nguyen on 28/05/2022.
//

import Foundation
import RealmSwift

// MARK: - Enum
enum SearchSection: Int, CaseIterable {
    case keywordHistory
    case around
    case more
    
    var title: String {
        switch self {
        case .keywordHistory:
            return "Base on What You've Read"
        case .around:
            return "Around the BBC"
        case .more:
            return "More Topic"
        }
    }
}

final class SearchViewModel {
    
    // MARK: - Properties
    var searchNews: [New] = []
    var historyNews: [History] = []
    var keywords: [String] = []

    private var notificationToken: NotificationToken?

    var data : [SearchSection: [String]] = [.keywordHistory: Config.baseTopic,
                                            .around: Config.aroundTopic,
                                            .more: Config.moreTopic]
    var completion: (() -> Void)?
    
    // MARK: - Fetch Data
    func fetchData(completion: @escaping (Bool) -> ()) {
        do {
            let realm = try Realm()
            keywords.removeAll()
            let myHistoryResult = realm.objects(History.self)
            keywords = Array(myHistoryResult)
                .sorted(by: { $0.date > $1.date })
                .map { $0.title }
            
            // Tạo ra mảng baseTopic để tránh double khi reload
//            var baseTopic: [String] = []
//            for key in historyNews {
//                if baseTopic.count == 4 {
//                    baseTopic.removeLast()
//                }
//                baseTopic.append(key.title)
//            }
//            data[.base] = baseTopic
            completion(true)
        } catch {
            completion(false)
        }
    }

    // MARK: - Observe
    func setupObserve() {
        do {
            let realm = try Realm()
            notificationToken = realm.objects(History.self).observe({ [weak self] (change) in
                guard let this = self else { return }
                this.completion?()
            })
        } catch  {
            print("Error Of Object From Realm")
        }
    }
    
    // MARK: - Realm
    func saveKeyword(_ keyword: String) {
        do {
            let realm = try Realm()
            try realm.write {
                let date = Date()
                let history = History(title: keyword, date: date)
                realm.create(History.self, value: history, update: .all)
            }
        } catch {
            print("Error From Object Realm")
        }
    }
    
    // MARK: - Cell
    func viewForMoreTopicCollectionCell(at indexPath: IndexPath) -> MoreTopicCollectionCellViewModel {
//        guard let sectionType = SearchSection(rawValue: indexPath.section),
//              let topics = data[sectionType] else { return MoreTopicCollectionCellViewModel() }
//        return MoreTopicCollectionCellViewModel(title: topics[indexPath.row])
        let sectionType = SearchSection.allCases[indexPath.section]
        let titleString = getTitle(at: indexPath.item, by: sectionType)
        return MoreTopicCollectionCellViewModel(title: titleString)
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

// MARK: - Dummy Data
extension SearchViewModel {

    struct Config {
        static var baseTopic: [String] = []
        static var aroundTopic: [String] = ["BBC Culuters", "BBC Travel"]
        static var moreTopic: [String] = ["General", "Europe", "Sports", "Business", "Middle East" , "Health", "Education", "Stories", "Football", "World", "Formula 1", "Cricket", "Science", "Paradise Papers", "Asia", "Tennis", "Golf", "Athletics", "Cycling", "Middle East", "Tech", "UK", "Rugby Union", "Entertainment"]
    }
}

// MARK: - Keyword
extension SearchViewModel {

    func getNumberItemOfSections(at index: Int, by type: SearchSection) -> Int {
        switch type {
        case .keywordHistory:
            let limitKeyword = 4
            return keywords.count >= limitKeyword ? limitKeyword : keywords.count
        case .around:
            // Dummy data
            return Config.aroundTopic.count
        case .more:
            // Dummy data
            return Config.moreTopic.count
        }
    }

    func getTitle(at index: Int, by type: SearchSection) -> String {
        switch type {
        case .keywordHistory:
            return keywords[index]
        case .around:
            // Dummy data
            return Config.aroundTopic[index]
        case .more:
            // Dummy data
            return Config.moreTopic[index]
        }
    }

    func getKeywordString(at index: Int) -> String? {
        guard index > keywords.count else { return nil }
        return keywords[index]
    }
}
