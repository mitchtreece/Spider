//
//  Data+Spider.swift
//  Pods
//
//  Created by Mitch Treece on 3/20/17.
//
//

import Foundation

public extension Data {
    
    public func json() -> Any? {
        
        guard let json = try? JSONSerialization.jsonObject(with: self) as? Any else {
            return nil
        }
        
        return json
        
    }
    
}
