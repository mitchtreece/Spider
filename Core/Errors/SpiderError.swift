//
//  SpiderError.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/27/18.
//

import Foundation

public enum SpiderError: SpiderErrorProtocol {
    
    case badUrl
    case badRequest(Request)
    case badResponse
    case badData
    case serialization
    case other(description: String)
    
    public var errorDescription: String? {
        
        switch self {
        case .badUrl: return "Bad URL"
        case .badRequest(let req): return "<\(req.path)>: Bad request"
        case .badResponse: return "Bad response"
        case .badData: return "Bad response data"
        case .serialization: return "Serialization failure"
        case .other(let desc): return desc
        }
        
    }
    
}
