//
//  JSONConvertible.swift
//  Pods
//
//  Created by Mitch Treece on 5/26/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

public typealias JSON = [String: Any]

/**
 `JSONConvertible` is a protocol describing the conversion to various `JSON` representations.
 */
public protocol JSONConvertible {
    
    /**
     A `JSON` representation.
     */
    var json: JSON? { get }
    
    /**
     A `JSON` array representation.
     */
    var jsonArray: [JSON]? { get }
    
    /**
     A `JSON` data representation.
     */
    var jsonData: Data? { get }
    
}

extension Dictionary: JSONConvertible {
    
    public var json: JSON? {
        
        if let json = self as? JSON {
            return json
        }
        
        return nil
        
    }
    
    public var jsonArray: [JSON]? {
        return nil
    }
    
    public var jsonData: Data? {
        
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        
        do {
            return try JSONSerialization.data(withJSONObject: self, options: [])
        }
        catch {
            return nil
        }
        
    }
    
}

extension Array: JSONConvertible {
    
    public var json: JSON? {
        return nil
    }
    
    public var jsonArray: [JSON]? {
        
        if let array = self as? [JSON] {
            return array
        }
        
        return nil
        
    }
    
    public var jsonData: Data? {
        
        guard JSONSerialization.isValidJSONObject(self) else { return nil }
        
        do {
            return try JSONSerialization.data(withJSONObject: self, options: [])
        }
        catch {
            return nil
        }
        
    }
    
}

extension Data: JSONConvertible {
    
    public var json: JSON? {
        
        var object: Any?
        
        do {
            object = try JSONSerialization.jsonObject(with: self)
        }
        catch {
            return nil
        }
        
        if let json = object as? JSON {
            return json
        }
        
        return nil
        
    }
    
    public var jsonArray: [JSON]? {
        
        var object: Any?
        
        do {
            object = try JSONSerialization.jsonObject(with: self)
        }
        catch {
            return nil
        }
        
        if let array = object as? [JSON] {
            return array
        }
        
        return nil
        
    }
    
    public var jsonData: Data? {
        return self
    }
    
}
