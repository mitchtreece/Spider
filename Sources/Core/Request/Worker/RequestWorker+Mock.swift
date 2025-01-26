//
//  RequestWorker+Mock.swift
//  Spider
//
//  Created by Mitch on 1/25/25.
//

import Foundation

public extension RequestWorker /* Mock */ {
    
    /// A mock request-worker used for testing.
    static var mock: RequestWorker {
                
        return RequestWorker(
            request: .mock,
            builder: .init(spider: .web),
            middlewares: [],
            isDebugEnabled: false
        )
        
    }
    
}
