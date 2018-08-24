//
//  ResponseRemoteError.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/23/18.
//

import Foundation

public struct ResponseRemoteError: _SpiderError {
    
    public var description: String
    public var response: Response
    
    public init(description: String, response: Response) {
        
        self.description = description
        self.response = response
        
    }
    
    public init(error: Response.Error) {
        
        self.description = error.localizedDescription
        
        var _response: Response!
        
        switch error {
        case .bad(let res): _response = res
        case .serialization(let res): _response = res
        }
        
        self.response = _response
        
    }
    
    public var errorDescription: String? {
        return "[\(response.statusCode.value)] <\(response.request.path)>: \(description)"
    }
    
}
