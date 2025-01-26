//
//  Request+Mock.swift
//  Spider
//
//  Created by Mitch on 1/25/25.
//

import Foundation

public extension Request /* Mock */ {
    
    /// A mock request used for testing.
    static var mock: Request {
        
        return .init(
            method: .custom("MOCK"),
            path: "mock"
        )
        
    }
    
}
