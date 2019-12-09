//
//  TokenRequestAuth.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/22/18.
//

import Foundation

/// `TokenRequestAuth` is a bearer token authorization type.
public struct TokenRequestAuth: RequestAuth {
    
    public var prefix: String? = "Bearer"
    public var field: String
    
    private var tokenString: String
    
    public var headerValue: String {
        return (self.prefix != nil) ? "\(self.prefix!) \(self.rawValue)" : self.rawValue
    }
    
    public var rawValue: String {
        return self.tokenString
    }
    
    /// Initializes a token auth object.
    /// - Parameter field: The HTTP request header field; _defaults to "Authorization"_.
    /// - Parameter value: The token value.
    public init(field: String = "Authorization", value: String) {
        
        self.field = field
        self.tokenString = value
        
    }
    
}
