//
//  SpiderError.swift
//  Pods
//
//  Created by Mitch Treece on 12/13/16.
//
//

import Foundation

public enum SpiderError: Error {
    
    case badRequest
    case badResponse
    case other(description: String)
    
}
