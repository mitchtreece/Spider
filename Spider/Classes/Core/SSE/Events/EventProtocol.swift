//
//  EventProtocol.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/6/20.
//

import Foundation

/// Protocol describing the characteristics of a server-side-event.
public protocol EventProtocol {
    
    /// The event's unique id.
    var id: String? { get }
    
    /// The event's type (or name).
    var type: String? { get }
    
    /// The event's data payload.
    var data: String? { get }
    
    /// The event's retry time.
    var retryTime: Int? { get }
    
}

public extension EventProtocol /* JSON data */ {
    
    /// A `JSON` representation of the event data.
    var jsonData: JSON? {
        
        guard let string = self.data,
              let data = string.data(using: .utf8) else { return nil }
        
        return try? JSONSerialization.jsonObject(
            with: data,
            options: []
        ) as? JSON
        
    }
    
    /// A `[JSON]` representation of the event data.
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
