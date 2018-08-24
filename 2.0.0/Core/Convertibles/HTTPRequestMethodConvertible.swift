//
//  HTTPRequestMethodConvertible.swift
//  Spider-Web
//
//  Created by Mitch Treece on 12/8/17.
//

import Foundation

/**
 `HTTPRequestMethodConvertible` is a protocol describing the conversion to various HTTP request method representations.
 */
public protocol HTTPRequestMethodConvertible {
    
    var httpRequestMethod: String { get }
    
}

extension String: HTTPRequestMethodConvertible {
    
    public var httpRequestMethod: String {
        return self.uppercased()
    }
    
}
