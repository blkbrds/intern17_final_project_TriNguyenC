//
//  News.swift
//  Final_Project
//
//  Created by tri.nguyen on 18/05/2022.
//

import Foundation

final class New {
    
    // MARK: Properties
    var author: String = ""
    var title: String = ""
    var description: String = ""
    var url: String = ""
    var urlToImage: String = ""
    var publishedAt: String = ""
    var content: String = ""
    var source: Source?
    
    // MARK: - init
    init(json: JSON) {
        if let source = json["source"] as? JSON {
            self.source = Source(json: source)
        }
        self.author = json["author"] as? String ?? ""
        self.title = json["title"] as? String ?? ""
        self.description = json["description"] as? String ?? ""
        self.url = json["url"] as? String ?? ""
        self.urlToImage = json["urlToImage"] as? String ?? ""
        self.publishedAt = json["publishedAt"] as? String ?? ""
        self.content = json["content"] as? String ?? ""
    }
}

final class Source {
    
    // MARK: - Properties
    var id: String = ""
    var name: String = ""
    
    // MARK: - init
    init(json: JSON) {
        self.id = json["id"] as? String ?? ""
        self.name = json["name"] as? String ?? ""
    }
}


