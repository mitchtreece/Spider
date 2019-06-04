//
//  SpiderResponse+String.swift
//  Spider-Web
//
//  Created by Mitch Treece on 4/13/18.
//

import Foundation

public extension SpiderResponse {
    
    /**
     Serializes a response's data into a `String`.
     - Parameter encoding: The string encoding to use (defaults to `utf8`).
     - Returns: An encoded data `String`.
     */
    func string(withEncoding encoding: String.Encoding = .utf8) -> String? {
        
        guard let data = data else { return nil }
        return String(data: data, encoding: encoding)
        
    }
    
}
