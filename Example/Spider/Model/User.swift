//
//  User.swift
//  Spider
//
//  Created by Mitch Treece on 5/27/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Spider

class User: Weavable {
    
    var id: String?
    var name: String?
    var username: String?
    var email: String?
    var phone: String?
    var website: String?
    
    required init?(json: JSON) {
        
        self.id = json["id"] as? String
        self.name = json["name"] as? String
        self.username = json["username"] as? String
        self.email = json["email"] as? String
        self.phone = json["phone"] as? String
        self.website = json["website"] as? String
        
    }
    
}
