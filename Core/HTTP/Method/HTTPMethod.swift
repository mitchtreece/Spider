//
//  HTTPMethod.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/24/18.
//

import Foundation

public enum HTTPMethod {
    
    case get
    case post
    case put
    case patch
    case delete
    
    case head
    case connect
    case options
    case trace
    
    case other(String)
    
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
        case .other(let method): return method.uppercased()
        }
        
    }
    
}
