//
//  PhotoManager.swift
//  Final_Project
//
//  Created by tri.nguyen on 19/05/2022.
//

import Foundation

final class PhotoManager {
    
    // MARK: - Singleton
    static let shared = PhotoManager()
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Image
    func downloadImage(with urlString: String, completion: @escaping (Data?) -> Void) {
        PhotoService.downloadImage(url: urlString) { data in
            completion(data)
        }
    }
}
