//
//  JSONRequestSerializer.swift
//  Pods
//
//  Created by Mitch Treece on 3/22/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

public class JSONRequestSerializer: RequestSerializer {
    
    public var prettyPrinted: Bool = false
    
    public func serialization(of object: Any?) -> Data? {
        
        guard let object = object else { return nil }
        guard JSONSerialization.isValidJSONObject(object) else { return nil }
        
        do {
            let options = prettyPrinted ? JSONSerialization.WritingOptions.prettyPrinted : JSONSerialization.WritingOptions(rawValue: 0)
            let data = try JSONSerialization.data(withJSONObject: object, options: options)
            return data
        }
        catch {
            return nil
        }
        
    }
    
}
