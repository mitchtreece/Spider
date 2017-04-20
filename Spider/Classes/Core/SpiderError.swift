//
//  SpiderError.swift
//  Pods
//
//  Created by Mitch Treece on 12/13/16.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

public enum SpiderError: Error {
    
    case badRequest
    case requestSerializationFailure
    case badResponse
    case other(description: String)
    
}
