//
//  MultipartRequest+Mock.swift
//  Spider
//
//  Created by Mitch on 1/25/25.
//

import Foundation

public extension MultipartRequest /* Mock */ {
    
    /// A mock multipart-request used for testing.
    static var mockMultipart: MultipartRequest {
        
        return .init(
            method: .custom("MOCK"),
            path: "mock",
            parameters: nil,
            files: []
        )
        
    }
    
}
