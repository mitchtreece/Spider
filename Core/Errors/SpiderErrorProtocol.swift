//
//  SpiderErrorProtocol.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/23/18.
//

import Foundation

public protocol SpiderErrorProtocol: LocalizedError {}

public extension SpiderErrorProtocol {
    
    public static func from(response: Response, provider: RemoteErrorProvider? = nil) -> SpiderErrorProtocol? {
        
        if let error = response.error {
            return HTTPError(description: error.localizedDescription, statusCode: response.statusCode, path: response.path)
        }
        
        if let provider = provider, let error = provider.error(from: response) {
            return error
        }
        
        return nil
        
    }
    
}
