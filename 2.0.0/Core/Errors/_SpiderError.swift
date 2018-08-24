//
//  _SpiderError.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/23/18.
//

import Foundation

public protocol _SpiderError: LocalizedError {}

public extension _SpiderError {
    
    public static func from(response: Response, remoteErrorProvider: ResponseRemoteErrorProvider? = nil) -> _SpiderError? {
        
        if let error = response.error {
            return HTTPError(description: error.localizedDescription, response: response)
        }
        
        if let provider = remoteErrorProvider, let error = provider.error(from: response) {
            return error
        }
        
        return nil
        
    }
    
}
