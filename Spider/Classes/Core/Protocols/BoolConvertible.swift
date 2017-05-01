//
//  BoolConvertible.swift
//  Pods
//
//  Created by Mitch Treece on 4/24/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

public protocol BoolConvertible {
    
    var bool: Bool? { get }
    var boolInt: Int? { get }
    var boolString: String? { get }
    
}

extension Bool: BoolConvertible {
    
    public static let trueString = "true"
    public static let falseString = "false"
    
    public var bool: Bool? {
        return self
    }
    
    public var boolInt: Int? {
        return self ? 1 : 0
    }
    
    public var boolString: String? {
        return self ? Bool.trueString : Bool.falseString
    }
    
}

extension String: BoolConvertible {
    
    public var bool: Bool? {
        
        guard let intValue = self.boolInt else { return nil }
        
        switch intValue {
        case 0: return false
        case 1: return true
        default: return nil
        }
        
    }
    
    public var boolInt: Int? {
        
        guard let stringValue = self.boolString else { return nil }
        
        switch stringValue {
        case Bool.trueString: return 1
        case Bool.falseString: return 0
        default: return nil
        }
        
    }
    
    public var boolString: String? {
        
        let value = self.lowercased()
        
        if value == Bool.trueString || value == "1" {
            return Bool.trueString
        }
        else if value == Bool.falseString || value == "0" {
            return Bool.falseString
        }
        
        return nil
        
    }
    
}
