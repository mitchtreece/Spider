//
//  SpiderError.swift
//  Pods
//
//  Created by Mitch Treece on 12/13/16.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

public enum SpiderError: Error {
    
    // General
    
    case invalidUrl
    case badRequest
    case requestSerializationFailure
    case badResponse
    case other(description: String)
    
    // Images
    
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
        case .requestSerializationFailure: return "Failed to serialize request"
        case .badResponse: return "Bad response"
        case .other(let desc): return desc
            
        case .invalidImageData: return "Invalid image data"
        }
                
    }
    
}
