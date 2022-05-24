//
//  NewsService.swift
//  Final_Project
//
//  Created by tri.nguyen on 18/05/2022.
//

import Foundation

final class NewsService {
    
    // MARK: - Get Service
    class func searchNews(keyword: String, pageSize: Int, completion: @escaping ([New]?) -> Void) {
        let urlString: String = ApiPath.searchNews
        let parameters: [String: String] = ["q": keyword,
                                            "pageSize": "\(pageSize)"]

        API.shared().request(urlString: urlString, parameters: parameters) { result in
            switch result {
            case .success(let data):
                var news: [New] = []
                if let data = data {
                    let jsonObject = data.toJSON()
                    if let articles = jsonObject["articles"] as? [JSON] {
                        for item in articles {
                            let new = New(json: item)
                            news.append(new)
                        }
                    }
                    completion(news)
                } else {
                    completion(nil)
                }
            case .failure:
                completion(nil)
            }
        }
    }
    
    class func searchNewsCategory(keyword: String, completion: @escaping ([New]?) -> Void) {
        let urlString: String = ApiPath.searchNews
        let parameters: [String: String] = ["q": keyword]

        API.shared().request(urlString: urlString, parameters: parameters) { result in
            switch result {
            case .success(let data):
                var news: [New] = []
                if let data = data {
                    let jsonObject = data.toJSON()
                    if let articles = jsonObject["articles"] as? [JSON] {
                        for item in articles {
                            let new = New(json: item)
                            news.append(new)
                        }
                    }
                    completion(news)
                } else {
                    completion(nil)
                }
            case .failure:
                completion(nil)
            }
        }
    }


    class func getTopHeadlines(country: String, completion: @escaping ([New]?) -> Void) {
        let urlString: String = ApiPath.topHeadlineNews
        let parameters: [String : String] = ["country": country]
        API.shared().request(urlString: urlString, parameters: parameters) { result in
            switch result {
            case .success(let data):
                var news: [New] = []
                if let data = data {
                    let jsonObject = data.toJSON()
                    if let articles = jsonObject["articles"] as? [JSON] {
                        for item in articles {
                            let new = New(json: item)
                            news.append(new)
                        }
                    }
                    completion(news)
                } else {
                    completion(nil)
                }
            case .failure:
                completion(nil)
            }
        }
    }
}
