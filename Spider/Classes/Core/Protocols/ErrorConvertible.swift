//
//  ErrorConvertible.swift
//  Pods
//
//  Created by Mitch Treece on 4/23/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

public protocol ErrorConvertible {
    
    var error: Error? { get }
    var errorString: String { get }
    
}

extension String: ErrorConvertible {
    
    public var error: Error? {
        
        // Find a way to dynamically get a better domain name
        return NSError(domain: "com.mitchtreece.Spider", code: -1, userInfo: [NSLocalizedDescriptionKey: self]) as Error
        
    }
    
    public var errorString: String {
        return self
    }
    
}

extension NSError: ErrorConvertible {
    
    public var error: Error? {
        
        return self as Error
        
    }
    
    public var errorString: String {
        
        if let desc = self.userInfo[NSLocalizedDescriptionKey] as? String {
            return desc
        }
        
        return ""
        
    }
    
}
