//
//  NSErrorExt.swift
//  Final_Project
//
//  Created by tri.nguyen on 25/05/2022.
//

import Foundation

private struct ErrorFieldKey {
    static var errors = "Errors"
}

extension NSError {

    var errorsString: [String] {
        set {
            objc_setAssociatedObject(self, &ErrorFieldKey.errors, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            guard let errors = objc_getAssociatedObject(self, &ErrorFieldKey.errors) as? [String] else { return [] }
            return errors
        }
    }
}
