//
//  Data+Spider.swift
//  Pods
//
//  Created by Mitch Treece on 3/20/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

public extension Data {
    
    public func json() -> Any? {
        
        guard let json = try? JSONSerialization.jsonObject(with: self) else {
            return nil
        }
        
        return json
        
    }
    
}
