//
//  SpiderResponse.swift
//  Pods
//
//  Created by Mitch Treece on 5/31/17.
//
//

import Foundation

/**
 A class encapsulating all relevant response properties.
 */
public class SpiderResponse {
    
    /**
     The initial request object.
     */
    private(set) public var req: SpiderRequest
    
    /**
     The `URLResponse` object.
     */
    private(set) public var res: URLResponse?
    
    /**
     The response data.
     */
    private(set) public var data: Data?
    
    /**
     The response's error object.
     */
    private(set) public var err: Error?
    
    /**
     The response's HTTP status code.
     */
    var statusCode: Int? {
        return (res as? HTTPURLResponse)?.statusCode
    }
    
    internal init(req: SpiderRequest, res: URLResponse?, data: Data?, err: Error?) {
        
        self.req = req
        self.res = res
        self.data = data
        self.err = err
        
    }
    
}
