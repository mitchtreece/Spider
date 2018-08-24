//
//  Response+Error.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/23/18.
//

import Foundation

public extension Response {
    
    public enum Error: _SpiderError {

        case bad(Response)
        case serialization(Response)
        
        public var errorDescription: String? {
            
            switch self {
            case .bad(let response): return "[\(response.statusCode.value)] <\(response.request.path)>: Bad response"
            case .serialization(let response): return "[\(response.statusCode.value)] <\(response.request.path)>: Serialization error"
            }
            
        }
        
    }

}
