//
//  RequestWorker+Mock.swift
//  Spider
//
//  Created by Mitch on 1/25/25.
//

import Foundation

public extension RequestWorker /* Mock */ {
    
    static var mock: RequestWorker {
                
        return RequestWorker(
            request: .init(
                method: .custom("MOCK"),
                path: "mock"
            ),
            builder: .init(spider: .web),
            middlewares: [],
            session: .shared,
            isDebugEnabled: false
        )
        
    }
    
}
