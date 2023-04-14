//
//  Event.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/6/20.
//

import EspressoLibSupport_Spider

/// Type that represents a server-side-event.
public struct RemoteEvent {
        
    /// Representation of the various remote event types.
    public enum EventType {
        
        /// A server-side-event.
        case event(String)
        
        /// A server-side-event message.
        case message
        
        /// The event type's name.
        public var name: String {
            
            switch self {
            case .event(let string): return string
            case .message: return "message"
            }
            
        }
        
    }
    
    /// The event's unique id.
    public let id: String?
    
    /// The event's raw type (or name).
    public let rawType: String?
    
    /// The event's type.
    ///
    /// This is based on the event's `rawType`.
    /// An event with no raw type is considered a message.
    public var type: EventType {
        
        guard let rawType = self.rawType else { return .message }
        return .event(rawType)
        
    }
    
    /// The event's data payload.
    public let data: String?
    
    /// The event's retry time.
    public let retry: Int?
        
    /// Flag indicating if the event is a message.
    ///
    /// Messages are special events that either
    /// specifically have a "message" type, or no type at all.
    public var isMessage: Bool {
    
        switch self.type {
        case .message: return true
        default: return false
        }
        
    }
    
    /// Flag indicating if this is a retry event.
    public var isRetry: Bool {
        
        let hasAnyValue = (self.id == nil || self.rawType == nil || self.data == nil)
        
        if let _ = self.retry, !hasAnyValue {
            return true
        }
        
        return false

    }
    
    /// Initializes a remote event.
    /// - parameter id: The event's ID.
    /// - parameter type: The event's type (or name).
    /// - parameter data: The event's data payload.
    /// - parameter retry: The event's retry interval.
    public init(id: String?,
                type: String?,
                data: String?,
                retry: Int?) {
        
        self.id = id
        self.rawType = type
        self.data = data
        self.retry = retry
        
    }
    
}

public extension RemoteEvent /* JSON */ {
    
    /// A `JSON` representation of the event data.
    var dataAsJson: JSON? {
        
        guard let string = self.data,
              let data = string.data(using: .utf8) else { return nil }
        
        return data
            .asJson()
        
    }
    
    /// A `[JSON]` representation of the event data.
    var dataAsJsonArray: [JSON]? {
        
        guard let string = self.data,
              let data = string.data(using: .utf8) else { return nil }
        
        return data
            .asJsonArray()
        
    }
    
}
