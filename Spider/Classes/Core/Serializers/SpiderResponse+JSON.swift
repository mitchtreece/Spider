//
//  SpiderResponse+JSON.swift
//  Pods
//
//  Created by Mitch Treece on 5/31/17.
//
//

import Foundation

public extension SpiderResponse {
    
    /**
     Serializes a response into `JSON`.
     - Returns: A `JSON` serialized object.
     */
    func json() -> JSON? {
        
        return self.data?.json
        
    }
    
    /**
     Serializes a response into a `JSON` array.
     - Returns: An array of `JSON` serialized objects.
     */
    func jsonArray() -> [JSON]? {
        
        return self.data?.jsonArray
        
    }
    
}
