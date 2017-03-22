//
//  SpiderToken.swift
//  Pods
//
//  Created by Mitch Treece on 3/12/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

public class SpiderToken {
    
    public var value: String
    public var headerField: String
    
    public init(value: String, headerField: String) {
        self.value = value
        self.headerField = headerField
    }
    
}
