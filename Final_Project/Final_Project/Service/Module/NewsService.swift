//
//  NewsService.swift
//  Final_Project
//
//  Created by tri.nguyen on 18/05/2022.
//

import Foundation
import Alamofire
import ObjectMapper

final class NewsService {
    
    // MARK: - Get Service
    class func searchNews(keyword: String, pageSize: Int, completion: @escaping Completion<[New]>) {
        let urlString = Api.Path.searchNews
        let parameters: [String: Any] = ["q": keyword,
                                         "pageSize": pageSize]
        api.request(method: .get,
                    urlString: urlString,
                    parameters: parameters) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    guard let jsonObj = data as? JSObject,
                          let jsonArr = jsonObj["articles"] as? JSArray else {
                        completion(.failure(Api.Error.json))
                        return
                    }
                    let news = Mapper<New>().mapArray(JSONArray: jsonArr)
                    completion(.success(news))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    class func searchNewsCategory(keyword: String, page: Int, pageSize: Int, completion: @escaping Completion<[New]>) {
        let urlString = Api.Path.searchNews
        let parameters: [String: Any] = ["q": keyword,
                                         "page": page,
                                         "pageSize": pageSize]
        api.request(method: .get,
                    urlString: urlString,
                    parameters: parameters) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    guard let jsonObj = data as? JSObject,
                          let jsonArr = jsonObj["articles"] as? JSArray else {
                        completion(.failure(Api.Error.json))
                        return
                    }
                    let news = Mapper<New>().mapArray(JSONArray: jsonArr)
                    completion(.success(news))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    class func getTopHeadlines(country: String, completion: @escaping Completion<[New]>) {
        let urlString: String = Api.Path.topHeadlineNews
        let parameters: [String : String] = ["country": country]
        
        api.request(method: .get,
                    urlString: urlString,
                    parameters: parameters) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    guard let jsonObjc = data as? JSObject,
                          let jsonArr = jsonObjc["articles"] as? JSArray else {
                        completion(.failure(Api.Error.json))
                        return
                    }
                    let new = Mapper<New>().mapArray(JSONArray: jsonArr)
                    completion(.success(new))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
