//
//  MyNewsViewModel.swift
//  Final_Project
//
//  Created by tri.nguyen on 01/06/2022.
//

import Foundation
import RealmSwift

// MARK: - Protocol
protocol MyNewsViewModelDelegate: AnyObject {
    func viewModel(_ viewModel: MyNewsViewModel, needperformAction action: MyNewsViewModel.Action)
}

final class MyNewsViewModel {
    
    // MARK: - Enum
    enum Action {
        case reloadData
    }
    
    // MARK: - Properties
    var myNews: [New] = []
    
    /// delegate
    weak var delegate: MyNewsViewModelDelegate?
    
    /// realm Notification
    private var notificationToken: NotificationToken?
    
    /// closure
    var completion: (() -> Void)?
    
    /// notification Center
    static let myNewNotification: String = "MyNewNotification"
    
    // MARK: - Obsever
    func setupObseve() {
        do {
            let realm = try Realm()
                        
            notificationToken = realm.objects(New.self).observe({ [weak self] (change) in
                guard let this = self else { return }
//                this.delegate?.viewModel(this, needperformAction: .reloadData)
                this.completion?()
//                NotificationCenter.default.post(name: NSNotification.Name(rawValue: MyNewsViewModel.kMyNewNontification), object: nil)
            })
        } catch  {
            print("Error Of Object From Realm")
        }
    }
    
    // MARK: - Fetch Data
    func fetchData(completion: @escaping (Bool) -> ()) {
        do {
            let realm = try Realm()
            
            let myNewsResult = realm.objects(New.self)
            myNews = Array(myNewsResult)
            
            completion(true)
            
        } catch {
            completion(false)
        }
    }
    
    
    // MARK: Realm DeleteAll
    func deleteAll(completion: (Bool) -> ()) {
            do {
                // realm
                let realm = try Realm()
                
                // results
                let myNewsResults = realm.objects(New.self)
                
                // delete all items
                try realm.write {
                    realm.delete(myNewsResults)
                }
                
                // call back
                completion(true)
                
            } catch {
                // call back
                completion(false)
            }
        }
    
    // MARK: - Cell
    func viewModelForCell(at indexPath: IndexPath) -> MainCellViewModel {
        return MainCellViewModel(new: myNews[indexPath.row])
    }
    
    func viewModelForDetail(at indexPath: IndexPath) -> DetailViewModel {
        return DetailViewModel(new: myNews[indexPath.row])
    }
}
