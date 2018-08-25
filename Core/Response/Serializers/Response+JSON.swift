//
//  Response+JSON.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/22/18.
//

import Foundation

public extension Response {
    
    /**
     Serializes a response into `JSON`.
     - Returns: A `JSON` serialized object.
     */
    public func json() -> JSON? {
        return self.data?.json
    }
    
    /**
     Serializes a response into a `JSON` array.
     - Returns: An array of `JSON` serialized objects.
     */
    public func jsonArray() -> [JSON]? {
        return self.data?.jsonArray
    }
    
}
