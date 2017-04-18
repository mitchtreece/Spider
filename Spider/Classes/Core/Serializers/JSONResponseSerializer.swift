//
//  JSONResponseSerializer.swift
//  Pods
//
//  Created by Mitch Treece on 4/17/17.
//
//

import Foundation

public class JSONResponseSerializer: ResponseSerializer {
    
    public func serialization(of data: Data?) -> Any? {
        
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
