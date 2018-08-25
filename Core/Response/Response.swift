//
//  Response.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/22/18.
//

import Foundation

public class Response {
    
    private(set) public var request: Request
    private(set) public var urlResponse: URLResponse?
    private(set) public var data: Data?
    private(set) public var error: SpiderError?
    
    public var statusCode: HTTPStatusCode {
        
        guard let _statusCode = (urlResponse as? HTTPURLResponse)?.statusCode else { return .none }
        return HTTPStatusCode(rawValue: _statusCode) ?? .none
        
    }
    
    public var path: String {
        return request.path
    }
        
    internal init(request: Request, urlResponse: URLResponse?, data: Data?, error: SpiderError?) {
        
        self.request = request
        self.urlResponse = urlResponse
        self.data = data
        self.error = error
        
    }
    
}
