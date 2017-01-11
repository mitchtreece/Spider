//
//  SpiderToken.swift
//  Pods
//
//  Created by Mitch Treece on 1/10/17.
//
//

import Foundation

public class SpiderToken {
    
    public var headerField: String
    public var value: String
    
    public init(headerField: String, value: String) {
        
        self.headerField = headerField
        self.value = value
        
    }
    
}
