//
//  ApiPath.swift
//  Final_Project
//
//  Created by tri.nguyen on 20/05/2022.
//

import Foundation

final class ApiPath {

    static var baseURL = "https://newsapi.org/v2"
    static var searchNews: String { return baseURL + "/everything" }
    static var topHeadlineNews: String { return baseURL + "/top-headlines"}
}


