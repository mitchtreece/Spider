//
//  HTTPError.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/23/18.
//

import Foundation

public struct HTTPError: _SpiderError {
    
    public var description: String
    public var response: Response
    
    public var statusCode: HTTPStatusCode {
        return response.statusCode
    }
    
    internal init(description: String, response: Response) {
        
        self.description = description
        self.response = response
        
    }
    
    public var errorDescription: String? {
        return "[\(statusCode.rawValue)] <\(response.request.path)>: \(description)"
    }
    
}
