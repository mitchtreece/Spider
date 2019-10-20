//
//  BasicRequestAuth.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/22/18.
//

import Foundation

public struct BasicRequestAuth: RequestAuth {
    
    public var username: String
    public var password: String
    
    public var prefix: String? = "Basic"
    public var field: String
    
    public var value: String {
        let encoded = Data("\(username):\(password)".utf8).base64EncodedString()
        return (prefix != nil) ? "\(prefix!) \(encoded)" : "\(encoded)"
    }
    
    public var rawValue: String {
        return Data("\(username):\(password)".utf8).base64EncodedString()
    }
    
    public init(username: String, password: String, field: String? = nil) {
        
        self.username = username
        self.password = password
        self.field = field ?? "Authorization"
        
    }

}
