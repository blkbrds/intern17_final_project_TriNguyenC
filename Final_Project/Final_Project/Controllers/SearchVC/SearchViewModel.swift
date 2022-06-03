//
//  SearchViewModel.swift
//  Final_Project
//
//  Created by tri.nguyen on 28/05/2022.
//

import Foundation
import RealmSwift

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
    
    // MARK: - Properties
    var searchNews: [New] = []
    var historyNews: [History] = []
    private var notificationToken: NotificationToken?

    var data : [SearchSection: [String]] = [.base: Config.baseTopic,
                                            .around: Config.aroundTopic,
                                            .more: Config.moreTopic]
    var completion: (() -> Void)?
    
    // MARK: - Fetch Data
    func fetchData(completion: @escaping (Bool) -> ()) {
        do {
            let realm = try Realm()

            let myHistoryResult = realm.objects(History.self)
            historyNews = Array(myHistoryResult)
            
            // Sort date
            historyNews.sort { (first, second) in
                first.date > second.date
            }
            
            // Tạo ra mảng baseTopic để tránh double khi reload
            var baseTopic: [String] = []
            for key in historyNews {
                if baseTopic.count == 4 {
                    baseTopic.removeLast()
                }
                baseTopic.append(key.title)
            }
            data[.base] = baseTopic
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
    func isAddRealmForHistory(query: String) {
        do {
            let realm = try Realm()
            try realm.write {
                let date = Date()
                let history = History(title: query, date: date)
                realm.create(History.self, value: history, update: .all)
            }
        } catch {
            print("Error From Object Realm")
        }
    }
    
    // MARK: - Cell
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

// MARK: - Dummy Data
extension SearchViewModel {

    struct Config {
        static var baseTopic: [String] = []
        static var aroundTopic: [String] = ["BBC Culuters", "BBC Travel"]
        static var moreTopic: [String] = ["General", "Europe", "Sports", "Business", "Middle East" , "Health", "Education", "Stories", "Football", "World", "Formula 1", "Cricket", "Science", "Paradise Papers", "Asia", "Tennis", "Golf", "Athletics", "Cycling", "Middle East", "Tech", "UK", "Rugby Union", "Entertainment"]
    }
}
