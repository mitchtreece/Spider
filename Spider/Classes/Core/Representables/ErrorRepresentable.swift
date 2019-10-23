//
//  ErrorRepresentable.swift
//  Pods
//
//  Created by Mitch Treece on 4/23/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

/// `ErrorRepresentable` is a protocol describing the conversion to various `Error` representations.
public protocol ErrorRepresentable {
    
    /// An error representation.
    var error: Error { get }
    
}

extension NSError: ErrorRepresentable {
    
    public var error: Error {
        return self as Error
    }
    
}

extension String: ErrorRepresentable {
    
    public var error: Error {
        
        let domain = Bundle.main.bundleIdentifier ?? "com.mitchtreece.Spider"
        
        return NSError(
            domain: domain,
            code: -1,
            userInfo: [NSLocalizedDescriptionKey: self]
        ).error
        
    }

}
