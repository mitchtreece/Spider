//
//  Request.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/22/18.
//

import Foundation

public class Request {
    
    public typealias Completion = (Response)->()
    
    /**
     Representation of the various states of an HTTP request.
     */
    public enum State {
        
        /// State representing a request that has not started yet.
        case pending
        
        /// State representing a request that is currently executing.
        case working
        
        /// State representing a request that has finished executing.
        case finished(Response)
        
    }
    
    /**
     The request's HTTP header.
     */
    public internal(set) var header = Header()
    
    /**
     The request's HTTP body.
     */
    public internal(set) var body = Body(data: nil)
    
    /**
     The request's HTTP method; _defaults to GET_.
     */
    public var method: HTTPMethod = .get
    
    /**
     The request's endpoint path to append to it's base URL **or** a fully qualified URL (if no global/request base URL is provided).
     ```
     "/users/12345"
     "http://base.url/v1/users/12345"
     ```
     */
    public var path: String = ""
    
    /**
     An optional parameter object to be passed along in the request body.
     */
    public var parameters: JSON?
    
    /**
     An optional authorization type to use for this request.
     Setting this will _override_ Spider's global authorization type.
     */
    public var auth: RequestAuth?
    
    /**
     The request's timeout interval in seconds; _defaults to 60_.
     */
    public var timeout: TimeInterval = 60
    
    /**
     The request's cache policy; _defaults to useProtocolCachePolicy_.
     */
    public var cachePolicy: NSURLRequest.CachePolicy = .useProtocolCachePolicy
    
    /**
     A boolean representing if the request can be performed using the cellular network; _defaults to true_.
     */
    public var allowsCellularAccess: Bool = true
    
    /**
     The current state of the request.
     */
    public internal(set) var state: State = .pending
    
    public init(method: HTTPMethod, path: String, parameters: JSON?, auth: RequestAuth?) {
        
        self.method = method
        self.path = path
        self.parameters = parameters
        self.auth = auth
        
    }
    
    private init() {
        //
    }
    
}

// TODO: Description
