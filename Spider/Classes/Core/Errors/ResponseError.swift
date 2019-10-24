//
//  ResponseError.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

public struct ResponseError: LocalizedError {
    
    public let response: Response<Data>
    public let description: String
    
    public init(response: Response<Data>, description: String) {
        
        self.response = response
        self.description = description
        
    }
    
    public init(response: Response<Data>, error: SpiderError) {
        
        self.response = response
        self.description = error.localizedDescription
        
    }
    
    public var errorDescription: String? {
        return self.description
    }
    
}
