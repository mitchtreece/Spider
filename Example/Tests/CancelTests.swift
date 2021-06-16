//
//  CancelTests.swift
//  Spider_Tests
//
//  Created by Mitch Treece on 10/23/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import Spider

class CancelTests: XCTestCase {
    
    private var spider = Spider()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRequestCancelImmediately() {
        
        let exp = expectation(description: "Request & worker have a cancelled state, and completion handler is never called")
        var completionCalled: Bool = false
        
        let request = Request(
            method: .get,
            path: "https://jsonplaceholder.typicode.com/posts/1"
        )
        
        let worker = self.spider.perform(request)
        worker.cancel()
        worker.dataResponse { response in
            completionCalled = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 10)
        XCTAssertFalse(completionCalled)
        XCTAssertEqual(request.state, Request.State.cancelled)
        XCTAssertEqual(worker.state, RequestWorker.State.cancelled)
        
    }
    
    func testRequestCancelAsync() {
        
        let exp = expectation(description: "Request & worker have a cancelled state, and completion handler is never called")
        var completionCalled: Bool = false
        
        let request = Request(
            method: .get,
            path: "http://www.mocky.io/v2/5db14a2c2e0000360050528e?mocky-delay=10000ms" // 10s delay
        )
        
        let worker = self.spider.perform(request)
        worker.dataResponse { response in
            completionCalled = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            worker.cancel()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 10)
        XCTAssertFalse(completionCalled)
        XCTAssertEqual(request.state, Request.State.cancelled)
        XCTAssertEqual(worker.state, RequestWorker.State.cancelled)
        
    }

}
