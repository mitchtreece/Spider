//
//  SpiderRequest.swift
//  Pods
//
//  Created by Mitch Treece on 12/14/16.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

/**
 `SpiderRequestHeader` is a wrapper over common properties of HTTP request headers.
 */
public class SpiderRequestHeader {
    
    /**
     Representation of the various common HTTP header `Accept` types.
     */
    public enum AcceptType {
        case application_json
        case application_javascript
        case text_json
        case text_javascript
        case text_html
        case text_plain
        case image_jpeg
        case custom(String)
    }
    
    /**
     Array of acceptable content types supported by this request.
     
     If none are provided, this request will accept _all_ content types.
     */
    public var accept: [AcceptType]?
    
    internal var other = [String: String]()
    
    /**
     Sets the value of a given HTTP header field.
     - Parameter value: The value to set
     - Parameter field: The HTTP header field
     */
    public func set(value: String, forField field: String) {
    
        other[field] = value
        
    }
        
    internal func acceptStringify() -> [String]? {
        
        guard let accept = accept else { return nil }
        
        var strings = [String]()
        
        for type in accept {
            switch type {
            case .application_json: strings.append("application/json")
            case .application_javascript: strings.append("application/javascript")
            case .text_json: strings.append("text/json")
            case .text_javascript: strings.append("text/javascript")
            case .text_html: strings.append("text/html")
            case .text_plain: strings.append("text/plain")
            case .image_jpeg: strings.append("image/jpeg")
            case .custom(let _type): strings.append(_type)
            }
        }
        
        return strings
        
    }
    
}

/**
 `SpiderRequest` represents a configurable HTTP request.
 */
public class SpiderRequest {
    
    /**
     Representation of the various states of an HTTP request.
     */
    public enum State {
        
        /// State representing a request that has not started yet.
        case pending
        
        /// State representing a request that is currently executing.
        case working
        
        /// State representing a request that has finished executing.
        case finished
        
    }
    
    /**
     Representation of the various HTTP request methods.
     */
    public enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    /**
     The base URL used when performing this request.
     */
    internal(set) var baseUrl: URLConvertible?
    
    /**
     The serializer used when performing this request.
     
     Setting this will _override_ Spider's global request serializer.
     */
    public var requestSerializer: Serializer?
    
    /**
     The serializer used on a request's response.
     
     Setting this will _override_ Spider's global response serializer.
     */
    public var responseSerializer: Serializer?
    
    /**
     The request's HTTP header.
     */
    public var header = SpiderRequestHeader()
    
    /**
     The request's HTTP method.
     */
    public var method: Method
    
    /**
     The request's endpoint path to append to it's base URL **or** a fully qualified URL (if no global/request base URL is provided).
     ```
     "/users/12345"
     "http://base.url/v1/users/12345"
     ```
     */
    public var path: String
    
    /**
     An optional param object to be passed along with the request.
     */
    public var parameters: Any?
    
    /**
     An optional authorization type to use for this request.
     
     Setting this will _override_ Spider's global authorization type.
     */
    public var auth: SpiderAuth?
    
    /**
     The request's timeout interval.
     
     Defaults to 60 seconds.
     */
    public var timeout: TimeInterval?
    
    /**
     The request's cache policy.
     
     Defaults to `CachePolicy.useProtocolCachePolicy`.
     */
    public var cachePolicy: NSURLRequest.CachePolicy?
    
    /**
     A boolean representing if the request can be performed using the cellular network.
     
     Defaults to `true`.
     */
    public var allowsCellularAccess: Bool?
    
    /**
     The current state of the request.
     */
    public internal(set) var state: State = .pending
    
    /**
     Initializes a new `SpiderRequest` with a method, path, parameters, & authorization type.
     - Parameter method: The HTTP method to use for this request
     - Parameter path: The request's endpoint path to append to it's base URL **or** a fully qualified URL (if no global/request base URL is provided).
        ```
        "/users/12345"
        "http://base.url/v1/users/12345"
        ```
     - Parameter parameters: An optional param object to be passed along with the request.
     - Parameter auth: An optional authorization type to use for this request.
        Setting this will _override_ Spider's global authorization type.
     */
    public init(method: Method, path: String, parameters: Any? = nil, auth: SpiderAuth? = nil) {
        
        self.method = method
        self.path = path
        self.parameters = parameters
        self.auth = auth
        
    }
    
}

extension SpiderRequest: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        
        var authString = "none"
        
        if let auth = auth {
            
            switch auth {
            case is BasicAuth: authString = "basic"
            case is TokenAuth: authString = "token"
            default: break
            }
            
            authString += " {\n  field: \"\(auth.headerField)\"\n  value: \"\(auth.value)\"\n}"
            
        }
        
        let baseUrl = self.baseUrl ?? "none"        
        let params = (parameters as? [String: Any])?.jsonString() ?? "none"
        
        return "<SpiderRequest - method: \(method.rawValue), baseUrl: \(baseUrl), path: \(path), auth: \(authString), params: \(params)>"
        
    }
    
    public var debugDescription: String {
        return description
    }
    
}
