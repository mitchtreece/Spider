//
//  User.swift
//  Spider
//
//  Created by Mitch Treece on 5/27/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Spider

struct User: Codable {
    
    var id: Int
    var name: String
    var username: String
    var email: String
    var phone: String
    var website: String
    
}

extension User: Serializable {
    
    static func serialized(from data: Data) -> SerializableType? {
        
        guard let json = JSON.serialized(from: data) as? JSON else { return nil }
        return Weaver<User>(json).map()
        
    }
    
}
