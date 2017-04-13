//
//  SpiderBasicAuth.swift
//  Pods
//
//  Created by Mitch Treece on 4/12/17.
//
//

import Foundation

public class SpiderBasicAuth {
    
    static let defaultHeaderField = "Authorization"
    
    public var username: String
    public var password: String
    
    internal var value: String {
        let auth = Data("\(username):\(password)".utf8).base64EncodedString()
        return "Basic \(auth)"
    }
    
    internal var rawValue: String {
        return Data("\(username):\(password)".utf8).base64EncodedString()
    }
    
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
}
