//
//  SpiderResponse+JSON.swift
//  Pods
//
//  Created by Mitch Treece on 5/31/17.
//
//

import Foundation

public extension SpiderResponse {
    
    public func json() -> JSON? {
        
        return self.data?.json
        
    }
    
    public func jsonArray() -> [JSON]? {
        
        return self.data?.jsonArray
        
    }
    
}
