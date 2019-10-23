//
//  Data+String.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/22/18.
//

import Foundation

public extension Data {
    
    /**
     Serializes data into a `String`.
     - Parameter encoding: The string encoding to use; _defaults to utf8_.
     - Returns: An encoded data `String`.
     */
    func string(with encoding: String.Encoding = .utf8) -> String? {
        return String(data: self, encoding: encoding)
    }
    
}
