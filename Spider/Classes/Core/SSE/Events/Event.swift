//
//  Event.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/6/20.
//

import Foundation

public struct Event: EventProtocol {
    
    public let id: String?
    public let type: String?
    public let data: String?
    
    internal func messageEvent() -> MessageEvent {
        
        return MessageEvent(
            id: self.id,
            data: self.data
        )
        
    }
    
}
