//
//  News.swift
//  Final_Project
//
//  Created by tri.nguyen on 18/05/2022.
//

import Foundation
import ObjectMapper
import RealmSwift

final class New: Object, Mappable {

    // MARK: Properties
    @objc dynamic var author: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var descriptions: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var urlToImage: String = ""
    @objc dynamic var publishedAt: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var source: Source?
    
    override class func primaryKey() -> String? {
        return "title"
    }
    
    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    func mapping(map: ObjectMapper.Map) {
        author <- map["author"]
        title  <- map["title"]
        descriptions <- map["description"]
        url <- map["url"]
        urlToImage <- map["urlToImage"]
        publishedAt <- map["publishedAt"]
        content <- map["content"]
        source <- map["source"]
    }
}

final class Source: Object, Mappable {
    // MARK: - Properties
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    
    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
