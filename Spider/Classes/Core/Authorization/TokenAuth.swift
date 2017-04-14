//
//  TokenAuth.swift
//  Pods
//
//  Created by Mitch Treece on 3/12/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

public class TokenAuth: SpiderAuth {
    
    public var _value: String
    public var field: String?
    
    public var type: String? = "Bearer"
    
    public var headerField: String {
        return field ?? SpiderConstants.Auth.defaultHeaderField
    }
    
    public var value: String {
        return (type != nil) ? "\(type!) \(_value)" : _value
    }
    
    public var rawValue: String {
        return _value
    }
    
    public init(value: String, headerField: String? = nil) {
        self._value = value
        self.field = headerField
    }
    
}
