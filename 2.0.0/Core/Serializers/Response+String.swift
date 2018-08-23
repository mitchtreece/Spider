//
//  Response+String.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/22/18.
//

import Foundation

public extension Response {
    
    /**
     Serializes a response's data into a `String`.
     - Parameter encoding: The string encoding to use; _defaults to utf8_.
     - Returns: An encoded data `String`.
     */
    public func string(withEncoding encoding: String.Encoding = .utf8) -> String? {
        
        guard let data = data else { return nil }
        return String(data: data, encoding: encoding)
        
    }
    
}
