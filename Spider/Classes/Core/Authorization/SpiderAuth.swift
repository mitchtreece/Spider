//
//  SpiderAuth.swift
//  Pods
//
//  Created by Mitch Treece on 4/13/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

/**
 `SpiderAuth` is a protocol describing an authorization type for an HTTP request.
 */
public protocol SpiderAuth {
    
    /**
     An optional authorization type. If provided, this gets prepended to the authorization value:
     ```
      [type] [--------value---------]
     "Bearer v12h3v1241v3i41hoi3b4j23"
     ```
     */
    var type: String? { get }
    
    /**
     The HTTP header field to use for authorization.
     */
    var headerField: String { get set }
    
    /**
     A fully encoded authorization string to be set on the header.
     ```
     "Bearer v12h3v1241v3i41hoi3b4j23"
     ```
     */
    var value: String { get }
    
    /**
     The authorization's raw value. This is typically the same as the authorization's value; minus the prepended `type` string.
     ```
     "v12h3v1241v3i41hoi3b4j23"
     ```
     */
    var rawValue: String { get }
    
}

public extension SpiderAuth {
    
    public var rawValue: String {
        return value
    }
    
}
