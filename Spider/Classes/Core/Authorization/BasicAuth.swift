//
//  BasicAuth.swift
//  Pods
//
//  Created by Mitch Treece on 4/12/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

/**
 `BasicAuth` is a base64 user/pass authorization type.
 */
public class BasicAuth: SpiderAuth {
    
    /**
     The username for authorization.
     */
    public var username: String
    
    /**
     The password for authorization.
     */
    public var password: String
    public var type: String? = "Basic"
    public var headerField: String
    
    public var value: String {
        let auth = Data("\(username):\(password)".utf8).base64EncodedString()
        return (type != nil) ? "\(type!) \(auth)" : "\(auth)"
    }
    
    public var rawValue: String {
        return Data("\(username):\(password)".utf8).base64EncodedString()
    }
    
    public init(username: String, password: String, headerField: String? = nil) {
        self.username = username
        self.password = password
        self.headerField = headerField ?? SpiderConstants.Auth.defaultHeaderField
    }
    
}
