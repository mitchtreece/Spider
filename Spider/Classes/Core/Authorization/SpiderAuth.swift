//
//  SpiderAuth.swift
//  Pods
//
//  Created by Mitch Treece on 4/13/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

public protocol SpiderAuth {
    
    var type: String? { get }
    var headerField: String { get }
    var value: String { get }
    var rawValue: String { get }
    
}

public extension SpiderAuth {
    
    public var rawValue: String {
        return value
    }
    
}
