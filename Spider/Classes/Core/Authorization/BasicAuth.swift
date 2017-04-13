//
//  BasicAuth.swift
//  Pods
//
//  Created by Mitch Treece on 4/12/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

public class BasicAuth: SpiderAuth {
        
    public var username: String
    public var password: String
    public var field: String?
    
    public func headerField() -> String {
        return field ?? SpiderConstants.Auth.defaultHeaderField
    }
    
    public var value: String {
        let auth = Data("\(username):\(password)".utf8).base64EncodedString()
        return "Basic \(auth)"
    }
    
    public var rawValue: String {
        return Data("\(username):\(password)".utf8).base64EncodedString()
    }
    
    public init(username: String, password: String, headerField: String? = nil) {
        self.username = username
        self.password = password
        self.field = headerField
    }
    
}
