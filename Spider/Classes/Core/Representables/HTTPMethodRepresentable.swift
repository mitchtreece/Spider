//
//  HTTPMethodRepresentable.swift
//  Spider-Web
//
//  Created by Mitch Treece on 12/8/17.
//

import Foundation

/// `HTTPMethodRepresentable` is a protocol describing the conversion to various HTTP request method representations.
public protocol HTTPMethodRepresentable {
    
    /// An `HTTPMethod` representation.
    var httpMethod: HTTPMethod { get }
    
}

extension String: HTTPMethodRepresentable {

    public var httpMethod: HTTPMethod {
        
        switch self.uppercased() {
        case HTTPMethod.get.value: return HTTPMethod.get
        case HTTPMethod.post.value: return HTTPMethod.post
        case HTTPMethod.put.value: return HTTPMethod.put
        case HTTPMethod.patch.value: return HTTPMethod.patch
        case HTTPMethod.delete.value: return HTTPMethod.delete
        case HTTPMethod.head.value: return HTTPMethod.head
        case HTTPMethod.connect.value: return HTTPMethod.connect
        case HTTPMethod.options.value: return HTTPMethod.options
        case HTTPMethod.trace.value: return HTTPMethod.trace
        default: return HTTPMethod.custom(self.uppercased())
        }
 
    }
    
}
