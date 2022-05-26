//
//  Errors.swift
//  Final_Project
//
//  Created by tri.nguyen on 25/05/2022.
//

import Foundation

typealias Errors = App.Errors

extension App {

    enum Errors: Error {

        case indexOutOfBound
        case initFailure
    }
}

extension App.Errors: CustomStringConvertible {

     var description: String {
        switch self {
        case .indexOutOfBound: return "Index is out of bound"
        case .initFailure: return "Init failure"
        }
    }
}
