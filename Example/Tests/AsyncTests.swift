//
//  AsyncTests.swift
//  Spider_Tests
//
//  Created by Mitch Treece on 1/26/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest
@testable import Spider

@available(iOS 13, *)
class AsyncTests: XCTestCase {
    
    private var spider = Spider()
    
    func testGetData() {
        
        let exp = expectation(description: "HTTP status code is OK & data is returned")

        Task {
            
            var status: HTTPStatusCode?
            var data: Data?
            
            let response = await self.spider
                .get("https://jsonplaceholder.typicode.com/posts/1")
                .dataResponse()
            
            status = response.statusCode
            data = response.value
            exp.fulfill()
            
            XCTAssertNotNil(status)
            XCTAssertTrue(status!.isOk)
            XCTAssertNotNil(data)
            
        }
        
        wait(for: [exp], timeout: 5)
        
    }
    
}
