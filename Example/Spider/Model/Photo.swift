//
//  Photo.swift
//  Spider
//
//  Created by Mitch Treece on 5/27/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Spider

struct Photo: Codable {
    
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
    
}

extension Photo: Serializable {
    
    static func serialized(from data: Data) -> SerializableType? {
        
        guard let json = JSON.serialized(from: data) as? JSON else { return nil }
        return Weaver<Photo>(json).map()
        
    }
    
}
