//
//  HTTPMethodConvertible.swift
//  Spider-Web
//
//  Created by Mitch Treece on 12/8/17.
//

import Foundation

/**
 `HTTPMethodConvertible` is a protocol describing the conversion to various HTTP request method representations.
 */
public protocol HTTPMethodConvertible {
    var httpMethod: String { get }
}

extension String: HTTPMethodConvertible {
    
    public var httpMethod: String {
        return self.uppercased()
    }
    
}
