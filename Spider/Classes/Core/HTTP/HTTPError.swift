//
//  HTTPError.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/23/18.
//

import Foundation

/// An HTTP error.
public struct HTTPError: Error {
    
    /// The error description.
    public var description: String
    
    /// The HTTP status code.
    public var statusCode: HTTPStatusCode?
    
    /// The associated request path.
    public var path: String
    
    internal init(description: String, statusCode: HTTPStatusCode?, path: String) {
        
        self.description = description
        self.statusCode = statusCode
        self.path = path
        
    }
    
    public var localizedDescription: String {
        
        if let statusCode = self.statusCode {
            return "[\(statusCode.rawValue)] <\(self.path)>: \(self.description)"
        }
        else {
            return "<\(self.path)>: \(self.description)"
        }
        
    }
    
}
