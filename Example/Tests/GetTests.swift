import XCTest
@testable import Spider

class GetTests: XCTestCase {
    
    private var spider: Spider!
    
    override func setUp() {
        
        super.setUp()
        self.spider = Spider.web
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetData() {
        
        let exp = expectation(description: "HTTP status code is OK & data is returned")
        var status: HTTPStatusCode?
        var data: Data?
        
        self.spider.get("https://jsonplaceholder.typicode.com/users/1").data { response in
            
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
        
        self.spider.get("https://jsonplaceholder.typicode.com/users/1").string { response in
            
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
        
        self.spider.get("https://jsonplaceholder.typicode.com/users/1").json { response in
            
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
        
        let exp = expectation(description: "HTTP status code is OK, JSON array is returned, & array isn't empty")
        var status: HTTPStatusCode?
        var array: [JSON]?
        
        self.spider.get("https://jsonplaceholder.typicode.com/users").jsonArray { response in
            
            status = response.statusCode
            array = response.value
            exp.fulfill()
            
        }
        
        wait(for: [exp], timeout: 5)
        XCTAssertNotNil(status)
        XCTAssertTrue(status!.isOk)
        XCTAssertNotNil(array)
        XCTAssertTrue(!(array!.isEmpty))
        
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
        
        let exp = expectation(description: "HTTP status code is OK & user is decoded")
        var status: HTTPStatusCode?
        var user: User?
        
        self.spider.get("https://jsonplaceholder.typicode.com/users/1").decode(User.self) { response in
            
            status = response.statusCode
            user = response.value
            exp.fulfill()
            
        }
        
        wait(for: [exp], timeout: 5)
        XCTAssertNotNil(status)
        XCTAssertTrue(status!.isOk)
        XCTAssertNotNil(user)
        
    }
    
}
