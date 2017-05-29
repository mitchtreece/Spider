//
//  Weavable.swift
//  Pods
//
//  Created by Mitch Treece on 5/27/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

public protocol Weavable {
    
    init?(json: JSON)
    
}

public extension Weavable {
    
    internal static func weave(_ json: JSON) -> Self? {
        
        if let obj = Self(json: json) {
            return obj
        }
        
        return nil
        
    }
    
}
