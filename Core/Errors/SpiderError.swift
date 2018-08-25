//
//  SpiderError.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/23/18.
//

import Foundation

public protocol SpiderError: LocalizedError {}

public extension SpiderError {
    
    public static func from(response: Response, remoteErrorProvider: ResponseRemoteErrorProvider? = nil) -> SpiderError? {
        
        if let error = response.error {
            return HTTPError(description: error.localizedDescription, statusCode: response.statusCode, path: response.path)
        }
        
        if let provider = remoteErrorProvider, let error = provider.error(from: response) {
            return error
        }
        
        return nil
        
    }
    
}
