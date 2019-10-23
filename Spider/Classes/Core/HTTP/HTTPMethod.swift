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
    case custom(String)
    
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
