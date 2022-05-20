//
//  API.swift
//  Final_Project
//
//  Created by tri.nguyen on 18/05/2022.
//

import Foundation

// MARK: - Error
enum APIError: Error {
    case error(String)
    case errorURL
    
    var localizedDescription: String {
        switch self {
        case .error(let string):
            return string
        case .errorURL:
            return "URL String is Error."
        }
    }
}

enum APIResult {
    case success(Data?)
    case failure(APIError)
}

struct API {
    
    // MARK: - Singleton
    private static var sharedAPI: API = {
        let sharedAPI = API()
        return sharedAPI
    }()
    
    static func shared() -> API {
        return sharedAPI
    }
    
    // MARK: - init
    private init() {}
}
