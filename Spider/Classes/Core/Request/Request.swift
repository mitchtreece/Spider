//
//  Request.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/22/18.
//

import Foundation

public class Request {
        
    /// Representation of the various states of an HTTP request.
    public enum State {
        
        /// State representing a request that has not yet started.
        case pending
        
        /// State representing a request that has errored before executing.
        case aborted
        
        /// State representing a request that has been cancelled.
        case cancelled
        
        /// State representing a request that is currently executing.
        case working
        
        /// State representing a request that has finished executing.
        case finished
        
    }
    
    /**
     The request's HTTP method; _defaults to GET_.
     */
    public var method: HTTPMethod = .get {
        didSet {
            createRequestBody()
        }
    }
    
    /**
     The request's endpoint path to append to it's base URL **or** a fully qualified URL (if no global/request base URL is provided).
     ```
     "/users/12345"
     "http://base.url/v1/users/12345"
     ```
     */
    public var path: String = ""
    internal var queryEncodedPath: String?
    
    /**
     An optional parameter object to be either passed along in the request body,
     or encoded into query parameters.
     */
    public var parameters: JSON? {
        didSet {
            createRequestBody()
        }
    }
    
    /**
     An optional authorization type to use for this request.
     Setting this will _override_ Spider's global authorization type.
     */
    public var authorization: RequestAuth?
    
    /**
     The request's HTTP headers.
     */
    public var headers = Headers()
    
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
     The request's HTTP body.
     */
    public internal(set) var body: Body?
    
    /// The request's start date.
    public internal(set) var startDate: Date?
    
    /// The request's end date.
    public internal(set) var endDate: Date?
    
    /// The request's working duration.
    public var duration: TimeInterval? {
        
        guard let start = self.startDate,
            let end = self.endDate else { return nil }
        
        return end.timeIntervalSince(start)
        
    }
    
    public var size: Data.Size {
        return self.body?.size ?? Data.Size(byteCount: 0)
    }
    
    /// The current state of the request.
    public internal(set) var state: State = .pending
    
    public init(method: HTTPMethod,
                path: String,
                parameters: JSON? = nil,
                authorization: RequestAuth? = nil) {
        
        self.method = method
        self.path = path
        self.parameters = parameters
        self.authorization = authorization
        
        createRequestBody()
                
    }
    
    private init() {
        //
    }
    
    internal func createRequestBody() {
        
        guard let parameters = self.parameters, !parameters.isEmpty else {
            
            self.body = nil
            self.queryEncodedPath = nil
            return
            
        }
        
        switch self.method {
        case .get:
                        
            guard var components = URLComponents(string: self.path) else { break }
                        
            components.queryItems = []
            
            for (key, value) in parameters {
                
                components.queryItems?.append(URLQueryItem(
                    name: key,
                    value: "\(value)"
                ))
                
            }
            
            guard let path = components.string else { break }
            self.queryEncodedPath = path
            self.body = nil
            
        default: self.body = Body(data: try? parameters.jsonData())
        }
        
    }
    
}
