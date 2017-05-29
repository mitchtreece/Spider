//
//  SpiderError.swift
//  Pods
//
//  Created by Mitch Treece on 12/13/16.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

/**
 Representation of common errors encountered while performing HTTP requests.
 */
public enum SpiderError: Error {
    
    // General
    
    /// Error representing an invalid URL.
    case invalidUrl
    
    /// Error representing an invalid request.
    case badRequest
    
    /// Error representing an invalid response.
    case badResponse
    
    /// Error representing a different, undefined problem.
    case other(description: String)
    
    // Images
    
    /// Error representing invalid image data.
    case invalidImageData
    
}

extension SpiderError: ErrorConvertible {
    
    public var error: Error? {
        return self
    }
    
    public var errorString: String? {
        
        switch self {
        case .invalidUrl: return "Invalid URL"
        case .badRequest: return "Bad request"
        case .badResponse: return "Bad response"
        case .other(let desc): return desc
            
        case .invalidImageData: return "Invalid image data"
        }
                
    }
    
}
