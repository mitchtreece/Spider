//
//  DataError.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/24/18.
//

import Foundation

public enum DataError: SpiderError {
    
    case invalid
    case invalidImageData
    
    public var errorDescription: String? {
        
        switch self {
        case .invalid: return "Invalid data"
        case .invalidImageData: return "Invalid image data"
        }
        
    }
    
}
