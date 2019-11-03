//
//  Middleware.swift
//  Spider-Web
//
//  Created by Mitch Treece on 11/3/19.
//

import Foundation

public class Middleware {

    public init() {
        //
    }
    
    public func next(_ response: Response<Data>) throws -> Response<Data> {
        fatalError("Middleware must override next(response:)")
    }
    
}
