//
//  Data+Append.swift
//  Spider-Web
//
//  Created by Mitch Treece on 11/10/17.
//

import Foundation

public extension Data {
    
    public mutating func append(string: String) {
        
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
        
    }
    
}
