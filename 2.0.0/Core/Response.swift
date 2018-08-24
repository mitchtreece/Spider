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
    private(set) public var error: Error?
    
    public var code: HTTPStatusCode? {
        
        guard let _code = (urlResponse as? HTTPURLResponse)?.statusCode else { return nil }
        return HTTPStatusCode(rawValue: _code)
        
    }
        
    internal init(request: Request, urlResponse: URLResponse?, data: Data?, error: Error?) {
        
        self.request = request
        self.urlResponse = urlResponse
        self.data = data
        self.error = error
        
    }
    
}
