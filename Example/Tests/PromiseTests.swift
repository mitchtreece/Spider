//
//  PromiseTests.swift
//  Spider_Tests
//
//  Created by Mitch Treece on 1/26/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import XCTest
@testable import Spider

class PromiseTests: XCTestCase {
    
    private var spider = Spider()
    
    func testGetData() {
        
        let exp = expectation(description: "HTTP status code is OK & data is returned")
        var status: HTTPStatusCode?
        var data: Data?

        self.spider
            .get("https://jsonplaceholder.typicode.com/posts/1")
            .dataResponse()
            .done { response in
                
                status = response.statusCode
                data = response.value
                exp.fulfill()
                
            }
            .cauterize()
        
        wait(for: [exp], timeout: 5)
        XCTAssertNotNil(status)
        XCTAssertTrue(status!.isOk)
        XCTAssertNotNil(data)
        
    }
    
}
