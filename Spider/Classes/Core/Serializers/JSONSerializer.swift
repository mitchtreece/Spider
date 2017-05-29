//
//  JSONSerializer.swift
//  Pods
//
//  Created by Mitch Treece on 3/22/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

/**
 `JSONSerializer` serializes data/objects to-and-from JSON.
 */
public class JSONSerializer: Serializer {
    
    public required init() {
        //
    }
    
    public func data(from object: Any?) -> Data? {
        
        guard let object = object else { return nil }
        guard JSONSerialization.isValidJSONObject(object) else { return nil }

        do {
            let data = try JSONSerialization.data(withJSONObject: object, options: [])
            return data
        }
        catch {
            return nil
        }
        
    }
    
    public func object(from data: Data?) -> Any? {
        
        guard let data = data else { return nil }
        guard JSONSerialization.isValidJSONObject(data) else { return nil }

        do {
            let object = try JSONSerialization.jsonObject(with: data)
            return object
        }
        catch {
            return nil
        }
        
    }
    
}
