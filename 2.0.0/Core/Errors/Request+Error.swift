//
//  Request+Error.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/23/18.
//

import Foundation

public extension Request {
    
    public enum Error: _SpiderError {
        
        case bad(Request)
        case other(description: String, request: Request?, response: Response?)
        
        public var errorDescription: String? {
            
            switch self {
            case .bad(let request): return "<\(request.path)>: Bad request"
            case .other(let description, let request, let response):
                
                var prefix = ""
                
                if let code = response?.code {
                    prefix += "[\(code.value)] "
                }
                
                if let path = request?.path {
                    prefix += "<\(path)>"
                }
                else if let path = response?.request.path {
                    prefix += "<\(path)>"
                }
                
                return "\(prefix): \(description)"
                
            }
            
        }
        
    }

}
