//
//  Request+Error.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/23/18.
//

import Foundation

public extension Request {
    
    public enum Error: SpiderError {
        
        case bad(Request)
        
        public var errorDescription: String? {
            
            switch self {
            case .bad(let request): return "<\(request.path)>: Bad request"
            }
            
        }
        
    }

}
