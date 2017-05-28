//
//  Weaver.swift
//  Pods
//
//  Created by Mitch Treece on 5/27/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

public class Weaver<T: Weavable> {
    
    private var json: JSON?
    private var jsonArray: [JSON]?
    
    public init(_ json: JSON) {
        self.json = json
    }
    
    public init(_ jsonArray: [JSON]) {
        self.jsonArray = jsonArray
    }
    
    public func map() -> T? {
        
        guard let json = self.json else { return nil }
        return T.weave(json)
        
    }
    
    public func arrayMap() -> [T]? {
        
        guard let array = self.jsonArray else { return nil }
        
        var objects = [T?]()
        for json in array {
            objects.append(T.weave(json))
        }
        
        return objects.flatMap({ return $0 })
        
    }
    
}
