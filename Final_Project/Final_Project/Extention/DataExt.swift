//
//  Data.Ext.swift
//  Final_Project
//
//  Created by tri.nguyen on 18/05/2022.
//

import Foundation

typealias JSON = [String: Any]

extension Data {
    
    func toJSON() -> JSON {
        var json: [String: Any] = [:]
        do {
            if let jsonObj = try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? JSON {
                json = jsonObj
            }
        } catch {
            print("JSON casting error")
        }
        return json
    }
}
