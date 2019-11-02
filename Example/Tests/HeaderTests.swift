//
//  HeaderTests.swift
//  Spider_Tests
//
//  Created by Mitch Treece on 11/2/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import Spider

class HeaderTests: XCTestCase {
    
    private var spider = Spider()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        
        super.tearDown()
        self.spider.headers = nil
        
    }
    
    func testSharedHeaders() {
        
        let exp = expectation(description: "Request is executed with shared header fields")
        var request: Request?
        
        let accept: [Headers.ContentType] = [.custom("spider/web")]
        let fields: [String: String] = ["foo": "bar"]
        
        self.spider.headers = Headers(
            content: nil,
            accept: accept,
            fields: fields
        )
        
        self.spider.get("https://jsonplaceholder.typicode.com/posts/1").data { response in
            request = response.request
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 5)
        XCTAssertNotNil(request)
        XCTAssertTrue(request!.headers.acceptTypes == accept)
        XCTAssertTrue(request!.headers.customFields == fields)
        
    }

}
