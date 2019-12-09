//
//  GetTests.swift
//  Spider_Tests
//
//  Created by Mitch Treece on 10/20/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import Spider

class GetTests: XCTestCase {
    
    private var spider = Spider()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetData() {
        
        let exp = expectation(description: "HTTP status code is OK & data is returned")
        var status: HTTPStatusCode?
        var data: Data?
        
        self.spider.get("https://jsonplaceholder.typicode.com/posts/1").data { response in
            
            status = response.statusCode
            data = response.value
            exp.fulfill()
            
        }
        
        wait(for: [exp], timeout: 5)
        XCTAssertNotNil(status)
        XCTAssertTrue(status!.isOk)
        XCTAssertNotNil(data)
        
    }
    
    func testGetString() {
        
        let exp = expectation(description: "HTTP status code is OK & string is returned")
        var status: HTTPStatusCode?
        var string: String?
        
        self.spider.get("https://jsonplaceholder.typicode.com/posts/1").string { response in
            
            status = response.statusCode
            string = response.value
            exp.fulfill()
            
        }
        
        wait(for: [exp], timeout: 5)
        XCTAssertNotNil(status)
        XCTAssertTrue(status!.isOk)
        XCTAssertNotNil(string)
        
    }
    
    func testGetJSON() {
        
        let exp = expectation(description: "HTTP status code is OK & JSON is returned")
        var status: HTTPStatusCode?
        var json: JSON?
        
        self.spider.get("https://jsonplaceholder.typicode.com/posts/1").json { response in
            
            status = response.statusCode
            json = response.value
            exp.fulfill()
            
        }
        
        wait(for: [exp], timeout: 5)
        XCTAssertNotNil(status)
        XCTAssertTrue(status!.isOk)
        XCTAssertNotNil(json)
        
    }
    
    func testGetJSONArray() {
        
        let exp = expectation(description: "HTTP status code is OK & JSON array is returned")
        var status: HTTPStatusCode?
        var array: [JSON]?
        
        self.spider.get("https://jsonplaceholder.typicode.com/posts").jsonArray { response in
            
            status = response.statusCode
            array = response.value
            exp.fulfill()
            
        }
        
        wait(for: [exp], timeout: 5)
        XCTAssertNotNil(status)
        XCTAssertTrue(status!.isOk)
        XCTAssertNotNil(array)
        
    }
    
    func testGetImage() {
        
        let exp = expectation(description: "HTTP status code is OK & image is returned")
        var status: HTTPStatusCode?
        var image: Image?
        
        self.spider.get("https://unsplash.it/500/?random").image { response in
            
            status = response.statusCode
            image = response.value
            exp.fulfill()
            
        }
        
        wait(for: [exp], timeout: 5)
        XCTAssertNotNil(status)
        XCTAssertTrue(status!.isOk)
        XCTAssertNotNil(image)
        
    }
    
    func testGetJSONAndDecode() {
        
        let exp = expectation(description: "HTTP status code is OK & post is decoded")
        var status: HTTPStatusCode?
        var post: Post?
        
        self.spider.get("https://jsonplaceholder.typicode.com/posts/1").decode(Post.self) { response in
            
            status = response.statusCode
            post = response.value
            exp.fulfill()
            
        }
        
        wait(for: [exp], timeout: 5)
        XCTAssertNotNil(status)
        XCTAssertTrue(status!.isOk)
        XCTAssertNotNil(post)
        
    }
    
    func testGetQueryParameters() {
        
        let exp = expectation(description: "Request path has expected query parameters")
        
        let path = "https://jsonplaceholder.typicode.com/posts"
        var finalPath: String?
        
        let parameters: JSON = [
            "sort": "top",
            "filter": "friends"
        ]
        
        self.spider.get(path, parameters: parameters).data { response in
            
            finalPath = response.urlResponse?.url?.absoluteString
            exp.fulfill()
            
        }
        
        wait(for: [exp], timeout: 5)
        XCTAssertNotNil(finalPath)
        XCTAssertTrue(finalPath!.contains("sort=top"))
        XCTAssertTrue(finalPath!.contains("filter=friends"))
        
    }
    
}
