//
//  HTTPError.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/23/18.
//

import Foundation

public struct HTTPError: LocalizedError {
    
    public var description: String
    public var statusCode: HTTPStatusCode?
    public var path: String
    
    internal init(description: String, statusCode: HTTPStatusCode?, path: String) {
        
        self.description = description
        self.statusCode = statusCode
        self.path = path
        
    }
    
    public var errorDescription: String? {
        
        if let statusCode = self.statusCode {
            return "[\(statusCode.rawValue)] <\(self.path)>: \(self.description)"
        }
        else {
            return "<\(self.path)>: \(self.description)"
        }
        
    }
    
}
