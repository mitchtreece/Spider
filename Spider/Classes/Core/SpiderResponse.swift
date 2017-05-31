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
    
    private(set) public var req: SpiderRequest
    private(set) public var res: URLResponse?
    private(set) public var data: Data?
    private(set) public var err: Error?
    
    init(req: SpiderRequest, res: URLResponse?, data: Data?, err: Error?) {
        self.req = req
        self.res = res
        self.data = data
        self.err = err
    }
    
}
