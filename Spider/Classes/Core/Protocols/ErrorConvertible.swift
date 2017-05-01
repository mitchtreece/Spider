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
    var errorString: String? { get }
    
}

extension NSError: ErrorConvertible {
    
    public var error: Error? {
        return self as Error
    }
    
    public var errorString: String? {
        
        if let localizedDescription = self.userInfo[NSLocalizedDescriptionKey] as? String {
            return localizedDescription
        }
        
        return nil
        
    }
    
}

extension String: ErrorConvertible {
    
    public var error: Error? {
        
        let domain = Bundle.main.bundleIdentifier ?? "com.mitchtreece.Spider"
        return NSError(domain: domain, code: -1, userInfo: [NSLocalizedDescriptionKey: self]).error
        
    }
    
    public var errorString: String? {
        return self
    }
    
}
