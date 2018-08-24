//
//  Request+Error.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/23/18.
//

import Foundation

public extension Request {
    
    public enum Error: LocalizedError {
        
        case badRequest(Request)
        case badResponse(Response)
        case serialization(Response)
        case other(description: String, request: Request?, response: Response?)
        
        static func from(response: Response) -> Error? {
            return nil
        }
        
        public var errorDescription: String? {
            
            switch self {
            case .badRequest(let request): return "<\(request.path)>: Bad request"
            case .badResponse(let response):
                
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
