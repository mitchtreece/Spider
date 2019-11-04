//
//  BasicRequestAuth.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/22/18.
//

import Foundation

/// `BasicRequestAuth` is a base64 user/pass authorization type.
public struct BasicRequestAuth: RequestAuth {
    
    /// The username for authorization.
    public var username: String
    
    /// The password for authorization.
    public var password: String
    
    public var prefix: String? = "Basic"
    public var field: String
    
    public var headerValue: String {
        return (self.prefix != nil) ? "\(self.prefix!) \(self.rawValue)" : "\(self.rawValue)"
    }
    
    public var rawValue: String {
        return Data("\(self.username):\(self.password)".utf8).base64EncodedString()
    }
    
    public init(username: String, password: String, field: String = "Authorization") {
        
        self.username = username
        self.password = password
        self.field = field
        
    }

}
