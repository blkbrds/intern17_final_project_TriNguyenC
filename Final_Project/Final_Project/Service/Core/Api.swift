//
//  Api.swift
//  Final_Project
//
//  Created by tri.nguyen on 25/05/2022.
//

import Foundation
import Alamofire

final class Api {

    struct Path {
        static let apiKey: String = "13de751985404bfd9aa348edba1c9972"
        static let baseURL: String = "https://newsapi.org/v2"
        static var searchNews: String { return baseURL + "/everything" }
        static var topHeadlineNews: String { return baseURL + "/top-headlines"}
    }
}

protocol URLStringConvertible {
    var urlString: String { get }
}

protocol ApiPath: URLStringConvertible {
    static var path: String { get }
}

private func / (lhs: URLStringConvertible, rhs: URLStringConvertible) -> String {
    return lhs.urlString + "/" + rhs.urlString
}

extension String: URLStringConvertible {
    var urlString: String { return self }
}

private func / (left: String, right: Int) -> String {
    return left.appending(path: "\(right)")
}
