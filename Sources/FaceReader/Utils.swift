//
//  Utils.swift
//  
//
//  Created by David Schmöcker on 11.09.21.
//

import Foundation

internal func clamp(_ value: Float?) -> Float? {
    if let value = value {
        return min(max(value, 0.0), 1.0)
    } else {
        return nil
    }
}
