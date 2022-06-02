//
//  DetailViewModel.swift
//  Final_Project
//
//  Created by tri.nguyen on 23/05/2022.
//

import Foundation
import RealmSwift

final class DetailViewModel {
 
    // MARK: - Properties
    var new: New
    
    // MARK: - Init
    init(new: New) {
        self.new = new
    }
        
    // MARK: - Load Image
    func getImageURL() -> URL? {
        let url = URL(string: new.urlToImage)
        return url
    }
    
    // MARK: - Realm
    func isAddedRealm() -> Bool {
        /// Fetch all objects news from Realm
        /// Check news.contain(new)
        /// If yes: call remove function
        /// If no: call add function
        
        do {
            let realm = try Realm()
            
            let newsResult = realm.objects(New.self).filter("title == %@", new.title)
            let news = Array(newsResult)
            return news.isNotEmpty
            
        } catch {
            print("Error Of Object From Realm")
            return false
        }
    }

    func addToRealm() {
        /// Add new to realm
        do {
            let realm = try Realm()
            try realm.write {
                realm.create(New.self, value: new, update: .all)
            }
        } catch {
            print("Error Of Object From Realm")
        }
    }

    func removeFromRealm() {
        /// Remove new from realm
        do {
            let realm = try Realm()
            let newsResult = realm.objects(New.self).filter("title = %@", new.title)
            guard let new = Array(newsResult).first else { return }
            try realm.write {
                realm.delete(new)
            }
        } catch {
            print("Error Of Object From Realm ")
        }
    }
}
