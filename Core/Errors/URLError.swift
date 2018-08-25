//
//  URLError.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/24/18.
//

import Foundation

public enum URLError: SpiderError {

    case invalid
    
    public var errorDescription: String? {
        
        switch self {
        case .invalid: return "Invalid URL"
        }
        
    }
    
}
