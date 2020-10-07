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
    
}

public extension EventProtocol {
    
    public jsonData: JSON? {
        // TODO
    }
    
}
