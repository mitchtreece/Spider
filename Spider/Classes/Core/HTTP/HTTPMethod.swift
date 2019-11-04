//
//  HTTPMethod.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/24/18.
//

import Foundation

/// Representation of the various HTTP methods.
public enum HTTPMethod {
    
    /// A GET HTTP method.
    case get
    
    /// A POST HTTP method.
    case post
    
    /// A PUT HTTP method.
    case put
    
    /// A PATCH HTTP method.
    case patch
    
    /// A DELETE HTTP method.
    case delete
    
    /// A HEAD HTTP method.
    case head
    
    /// A CONNECT HTTP method.
    case connect
    
    /// An OPTIONS HTTP method.
    case options
    
    /// A TRACE HTTP method.
    case trace
    
    /// A custom HTTP method.
    case custom(String)
    
    /// An array of all the HTTP method raw values.
    public static var allValues: [String] {
        
        return [
            HTTPMethod.get.value,
            HTTPMethod.post.value,
            HTTPMethod.put.value,
            HTTPMethod.patch.value,
            HTTPMethod.delete.value,
            HTTPMethod.head.value,
            HTTPMethod.connect.value,
            HTTPMethod.options.value,
            HTTPMethod.trace.value
        ]
        
    }
    
    /// The method's raw value.
    public var value: String {
        
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .put: return "PUT"
        case .patch: return "PATCH"
        case .delete: return "DELETE"
        case .head: return "HEAD"
        case .connect: return "CONNECT"
        case .options: return "OPTIONS"
        case .trace: return "TRACE"
        case .custom(let method): return method.uppercased()
        }
        
    }
    
}
