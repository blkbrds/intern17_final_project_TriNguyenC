//
//  MyNewsViewModel.swift
//  Final_Project
//
//  Created by tri.nguyen on 01/06/2022.
//

import Foundation
import RealmSwift

final class MyNewsViewModel {
    
    // MARK: - Properties
    var myNews: [New] = []
    
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
    
    // MARK: - Cell
    func viewModelForCell(at indexPath: IndexPath) -> MainCellViewModel {
        return MainCellViewModel(new: myNews[indexPath.row])
    }
    
    func viewModelForDetail(at indexPath: IndexPath) -> DetailViewModel {
        return DetailViewModel(new: myNews[indexPath.row])
    }
}
