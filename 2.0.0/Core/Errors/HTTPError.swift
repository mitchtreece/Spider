//
//  HTTPError.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/23/18.
//

import Foundation

public struct HTTPError: _SpiderError {
    
    public var description: String
    public var response: Response?
    
    public var request: Request? {
        return response?.request
    }
    
    public var statusCode: HTTPStatusCode? {
        return response?.code
    }
    
    public var errorDescription: String? {
        
        var prefix = ""
        
        if let code = statusCode {
            prefix += "[\(code.value)] "
        }
        
        if let path = request?.path ?? response?.request.path {
            prefix += "<\(path)>"
        }
        
        if prefix.count != 0 {
            return "\(prefix): \(description)"
        }
        
        return description
        
    }
    
}
