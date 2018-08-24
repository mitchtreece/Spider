//
//  _SpiderError.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/23/18.
//

import Foundation

public protocol _SpiderError: LocalizedError {}

public extension _SpiderError {
    
    static func from(response: Response) -> _SpiderError? {
        
        if let error = response.error {
            return HTTPError(description: error.localizedDescription, response: response)
        }
        
        // TODO: JSON (API) Error?
        
        return nil
        
    }
    
}
