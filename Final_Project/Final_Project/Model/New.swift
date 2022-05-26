//
//  News.swift
//  Final_Project
//
//  Created by tri.nguyen on 18/05/2022.
//

import Foundation
import ObjectMapper

final class New: Mappable {

    // MARK: Properties
    var author: String = ""
    var title: String = ""
    var description: String = ""
    var url: String = ""
    var urlToImage: String = ""
    var publishedAt: String = ""
    var content: String = ""
    var source: Source?
    
    required convenience init?(map: Map) {
        self.init()
    }

    
    func mapping(map: Map) {
        author <- map["author"]
        title  <- map["title"]
        description <- map["description"]
        url <- map["url"]
        urlToImage <- map["urlToImage"]
        publishedAt <- map["publishedAt"]
        content <- map["content"]
        source <- map["source"]
    }
}

final class Source: Mappable {

    // MARK: - Properties
    var id: String = ""
    var name: String = ""

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}


