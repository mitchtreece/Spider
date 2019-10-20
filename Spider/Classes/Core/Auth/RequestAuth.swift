//
//  RequestAuth.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/22/18.
//

import Foundation

public protocol RequestAuth {
    
    var prefix: String? { get }
    var field: String { get set }
    var value: String { get }
    var rawValue: String { get }
    
}

public extension RequestAuth {
    
    public var rawValue: String {
        return value
    }
    
}
