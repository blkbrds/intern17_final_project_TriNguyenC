//
//  API.Request.swift
//  Final_Project
//
//  Created by tri.nguyen on 18/05/2022.
//

import Foundation

extension API {
    
    func request(urlString: String, parameters: [String: String], completion: @escaping (APIResult) -> Void) {
        guard var components = URLComponents(string: urlString) else {
            completion(.failure(APIError.error("URL is not valid")))
            return
        }

        var params: [String: String] = parameters
        params["apiKey"] = "13de751985404bfd9aa348edba1c9972"
        components.queryItems = params.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")

        guard let url = components.url else {
            completion(.failure(APIError.error("URL is not valid")))
            return
        }

        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.error(error.localizedDescription)))
                } else {
                    if let data = data {
                        completion(.success(data))
                    }
                }
            }
        }.resume()
    }
}
