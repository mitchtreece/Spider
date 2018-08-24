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
            case .bad(let response):
                
                var prefix = ""
                
                if let code = response.code {
                    prefix = "[\(code.value)]"
                }
                
                prefix += (prefix.count > 0) ? " <\(response.request.path)>" : "<\(response.request.path)>"
                return "\(prefix): Bad response"
                
            case .serialization(let response):
                
                var prefix = ""
                
                if let code = response.code {
                    prefix = "[\(code.value)]"
                }
                
                prefix += (prefix.count > 0) ? " <\(response.request.path)>" : "<\(response.request.path)>"
                return "\(prefix): Serialization error"
            }
            
        }
        
    }

}
