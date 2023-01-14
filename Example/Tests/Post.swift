//
//  Post.swift
//  Spider_Tests
//
//  Created by Mitch Treece on 10/20/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Spider
import Espresso

struct Post: Codable {
    
    let id: Int
    let userId: Int
    let title: String
    let body: String
    
    static var mockJSON: JSON {
        
        return [
            "userId": 1,
            "title": "Mock Post",
            "body": "This is a mock post."
        ]
        
    }
    
}
