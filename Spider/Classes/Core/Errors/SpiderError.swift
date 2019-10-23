//
//  SpiderError.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/27/18.
//

import Foundation

public enum SpiderError: LocalizedError {
    
    case badUrl
    case badRequest
    case badResponse
    case badResponseData
    case serialization
    case compactMap
    case cancelled
    case other(description: String)
    
    public var errorDescription: String? {
        
        switch self {
        case .badUrl: return "Bad url"
        case .badRequest: return "Bad request"
        case .badResponse: return "Bad response"
        case .badResponseData: return "Bad response data"
        case .serialization: return "Serialization failure"
        case .compactMap: return "Compact map"
        case .cancelled: return "Cancelled"
        case .other(let desc): return desc
        }
        
    }
    
}
