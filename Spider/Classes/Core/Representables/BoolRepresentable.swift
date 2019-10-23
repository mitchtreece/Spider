//
//  BoolRepresentable.swift
//  Pods
//
//  Created by Mitch Treece on 4/24/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

/// `BoolRepresentable` is a protocol describing the conversion to various `Bool` representations.
public protocol BoolRepresentable {
    
    /// A boolean representation.
    var bool: Bool { get }
    
}

extension BoolRepresentable {
    
    /// A boolean integer representation (0 _or_ 1).
    var boolInt: Int {
        return self.bool ? 1 : 0
    }
    
    /// A boolean string representation ("true" _or_ "false").
    var boolString: String {
        return self.bool ? "true" : "false"
    }
    
}

extension Bool: BoolRepresentable {

    public var bool: Bool {
        return self
    }
    
}

extension Int: BoolRepresentable {
    
    public var bool: Bool {
        return (self > 0) ? true : false
    }
    
}

extension String: BoolRepresentable {
    
    public var bool: Bool {
        
        if self.lowercased() == "true" || self == "1" {
            return true
        }
        
        return false
        
    }
    
}
