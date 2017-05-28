//
//  Photo.swift
//  Spider
//
//  Created by Mitch Treece on 5/27/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Spider

class Photo: Weavable {
    
    var id: String?
    var title: String?
    var url: String?
    var thumbnailUrl: String?
    
    required init?(json: JSON) {
        
        self.id = json["id"] as? String
        self.title = json["title"] as? String
        self.url = json["url"] as? String
        self.thumbnailUrl = json["thumbnailUrl"] as? String
        
    }
    
}
