//
//  RequestAuth.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/22/18.
//

import Foundation

/// `RequestAuth` is a protocol describing an authorization type for an HTTP request.
public protocol RequestAuth {
    
    /// An optional authorization prefix.
    ///
    /// If provided, this gets prepended to the authorization value.
    /// ```
    /// [prefix] [----------value---------]
    ///  Bearer   v12h3v1241v3i41hoi3b4j23
    /// ```
    var prefix: String? { get }
    
    /// The HTTP header field to use for authorization.
    var field: String { get set }
    
    /// A fully encoded authorization string to be set on the header.
    /// ```
    /// "Bearer v12h3v1241v3i41hoi3b4j23"
    /// ```
    var headerValue: String { get }
    
    /// The authorization's raw value. This is typically the same as the authorization's value; minus the prepended `prefix` string.
    /// ```
    /// "v12h3v1241v3i41hoi3b4j23"
    /// ```
    var rawValue: String { get }
    
}

public extension RequestAuth {
    
    var rawValue: String {
        return self.headerValue
    }
    
}
