//
//  PostTests.swift
//  Spider_Tests
//
//  Created by Mitch Treece on 10/20/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import Spider

class PostTests: XCTestCase {
    
    private var spider = Spider()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPostJSON() {
        
        let exp = expectation(description: "HTTP status code is OK & created post ID is returned")
        var status: HTTPStatusCode?
        var postId: Int?
        
        self.spider.post(
            "https://jsonplaceholder.typicode.com/posts",
            parameters: Post.mockJSON
        )
        .jsonResponse { response in
            
            status = response.statusCode
            postId = (response.value?["id"] as? Int)
            exp.fulfill()
            
        }
        
        wait(for: [exp], timeout: 5)
        XCTAssertNotNil(status)
        XCTAssertTrue(status!.isOk)
        XCTAssertNotNil(postId)
        
    }

}
