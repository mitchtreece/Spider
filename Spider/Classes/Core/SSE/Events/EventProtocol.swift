//
//  EventProtocol.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/6/20.
//

import Foundation

public protocol EventProtocol {
    
    var id: String? { get }
    var type: String? { get }
    var data: String? { get }
    var retryTime: Int? { get }
    
}

public extension EventProtocol /* JSON data */ {
    
    var jsonData: JSON? {
        
        guard let string = self.data,
              let data = string.data(using: .utf8) else { return nil }
        
        return try? JSONSerialization.jsonObject(
            with: data,
            options: []
        ) as? JSON
        
    }
    
    var jsonArrayData: [JSON]? {
        
        guard let string = self.data,
              let data = string.data(using: .utf8) else { return nil }
        
        return try? JSONSerialization.jsonObject(
            with: data,
            options: []
        ) as? [JSON]
        
    }
    
}

internal extension EventProtocol /* Retry */ {
    
    var isRetry: Bool {
        
        let hasAnyValue = (self.id == nil || self.type == nil || self.data == nil)
        
        if let _ = self.retryTime, !hasAnyValue {
            return true
        }
        
        return false

    }
    
}
