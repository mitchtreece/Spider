//
//  MessageEvent.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/6/20.
//

import Foundation

public struct MessageEvent: EventProtocol {
    
    public let id: String?
    public let data: String?
    public var type: String? {
        return "message"
    }
    
}
