//
//  Response+Error.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/23/18.
//

import Foundation

public extension Response {
    
    public enum Error: SpiderError {

        case bad(Response)
        case serialization(Response)
        
        public var errorDescription: String? {
            
            switch self {
            case .bad(let response): return "[\(response.statusCode.rawValue)] <\(response.request.path)>: Bad response"
            case .serialization(let response): return "[\(response.statusCode.rawValue)] <\(response.request.path)>: Serialization error"
            }
            
        }
        
    }

}
