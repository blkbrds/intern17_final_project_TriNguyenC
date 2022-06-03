//
//  History.swift
//  Final_Project
//
//  Created by tri.nguyen on 03/06/2022.
//

import Foundation
import RealmSwift

final class History: Object {
    
    // MARK: - Properties
    @objc dynamic var title: String = ""
    @objc dynamic var date: Date = Date()

    override class func primaryKey() -> String? {
        return "title"
    }
    
    // MARK: - Init
    convenience init(title: String, date: Date) {
        self.init()
        self.title = title
        self.date = date
    }
}
