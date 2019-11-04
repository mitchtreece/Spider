//
//  Middleware.swift
//  Spider-Web
//
//  Created by Mitch Treece on 11/3/19.
//

import Foundation

/// Protocol describing the attributes of a response middleware.
public class Middleware {

    public init() {
        //
    }
    
    /// Validates and/or transforms a response.
    /// - Parameter response: The response.
    /// - Returns: The validated and/or transformed response.
    public func next(_ response: Response<Data>) throws -> Response<Data> {
        fatalError("Middleware must override next(response:)")
    }
    
}
