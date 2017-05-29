//
//  TokenAuth.swift
//  Pods
//
//  Created by Mitch Treece on 3/12/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

/**
 `TokenAuth` is a bearer token authorization type.
 */
public class TokenAuth: SpiderAuth {
    
    private var _value: String
    public var type: String? = "Bearer"
    public var headerField: String
    
    public var value: String {
        return (type != nil) ? "\(type!) \(_value)" : _value
    }
    
    public var rawValue: String {
        return _value
    }
    
    public init(value: String, headerField: String? = nil) {
        self._value = value
        self.headerField = headerField ?? SpiderConstants.Auth.defaultHeaderField
    }
    
}
