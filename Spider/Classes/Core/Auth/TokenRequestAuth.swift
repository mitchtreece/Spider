//
//  TokenRequestAuth.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/22/18.
//

import Foundation

public struct TokenRequestAuth: RequestAuth {
    
    public var prefix: String? = "Bearer"
    public var field: String
    
    private var _value: String
    
    public var value: String {
        return (prefix != nil) ? "\(prefix!) \(_value)" : _value
    }
    
    public var rawValue: String {
        return _value
    }
    
    public init(field: String? = nil, value: String) {
        
        self._value = value
        self.field = field ?? "Authorization"
        
    }
    
}
