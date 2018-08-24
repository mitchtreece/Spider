//
//  SpiderRequest.swift
//  Pods
//
//  Created by Mitch Treece on 12/14/16.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

/**
 `SpiderRequest` represents a configurable HTTP request.
 */
public class SpiderRequest {
    
    /**
     `Header` is a wrapper over common properties of HTTP request headers.
     */
    public class Header {
        
        /**
         Representation of the various common HTTP header `Content` types.
         */
        public enum ContentType {
            
            case application_json
            case multipart
            case custom(String)
            
            func value(for request: SpiderRequest) -> String {
                
                switch self {
                case .application_json: return "application/json"
                case .multipart:
                    
                    let boundary = (request as? SpiderMultipartRequest)?.boundary ?? UUID().uuidString
                    return "multipart/form-data; boundary=\(boundary)"
                    
                case .custom(let type): return type
                }
                
            }
            
        }
        
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
            
            func value() -> String {
                
                switch self {
                case .application_json: return "application/json"
                case .application_javascript: return "application/javascript"
                case .text_json: return "text/json"
                case .text_javascript: return "text/javascript"
                case .text_html: return "text/html"
                case .text_plain: return "text/plain"
                case .image_jpeg: return "image/jpeg"
                case .custom(let type): return type
                }
                
            }
            
        }
        
        /**
         The type of content provided by the request.
         */
        public var content: ContentType?
        
        /**
         Array of acceptable content types supported by this request.
         
         If none are provided, this request will accept _all_ content types.
         */
        public var accept: [AcceptType]?
        
        internal var other = [String: String]()
        internal weak var request: SpiderRequest?

        /**
         Sets the value of a given HTTP header field.
         - Parameter value: The value to set
         - Parameter field: The HTTP header field
         */
        public func set(value: String, forField field: String) {
            other[field] = value
        }
        
        internal init(request: SpiderRequest?) {
            self.request = request
        }
        
    }
    
    /**
     `Body` is a wrapper over an HTTP request body.
     */
    public struct Body {
        public var data: Data?
    }
    
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
     The base URL used when performing this request.
     */
    internal(set) var baseUrl: URLConvertible?
    
    /**
     The request's HTTP method.
     
     Defaults to _GET_.
     */
    public var method: String = "GET"
    
    /**
     The request's HTTP header.
     */
    public internal(set) var header: Header!
    
    /**
     The request's HTTP body.
     */
    public internal(set) var body: Body!
    
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
    public var auth: SpiderAuth?
    
    /**
     The request's timeout interval.
     
     Defaults to _60_ seconds.
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
     - Parameter method: The HTTP method to use for the request
     - Parameter path: The request's endpoint path to append to it's base URL **or** a fully qualified URL (if no global/request base URL is provided).
        ```
        "/users/12345"
        "http://base.url/v1/users/12345"
        ```
     - Parameter parameters: An optional parameter object to be passed along in the request body.
     - Parameter auth: An optional authorization type to use for this request.
        Setting this will _override_ Spider's global authorization type.
     */
    public init(method: String, path: String, parameters: JSON? = nil, auth: SpiderAuth? = nil) {
        
        header = Header(request: self)
        body = Body(data: parameters?.jsonData)
        
        self.method = method
        self.path = path
        self.parameters = parameters
        self.auth = auth
        
    }
    
    private init() {
        //
    }
    
    public func printCURL() {
        
        var url = path
        if let base = baseUrl?.urlString {
            url = "\(base)\(path)"
        }
        
        var curl: String = "curl \(url) \\\n"
        curl += "-X \(method) \\\n"
        
        // Header
        
        if let auth = auth {
            curl += "-H \"\(auth.headerField): \(auth.value)\" \\\n"
        }
        
        if let accept = header.accept {
            
            var acceptString = "-H \"\(SpiderConstants.Request.headerAcceptField): "
            
            for i in 0..<accept.count {
                
                let type = accept[i]
                
                if i != (accept.count - 1) {
                    acceptString += "\(type.value()), "
                }
                else {
                    acceptString += "\(type.value())\" \\\n"
                }
                
            }
            
            curl += acceptString
            
        }
        
        if let content = header.content {
            curl += "-H \"\(SpiderConstants.Request.headerContentField): \(content.value(for: self))\" \\\n"
        }
        
        for (key, value) in header.other {
            curl += "-H \"\(key): \(value)\" \\\n"
        }
        
        // Data
        
        if let multipart = self as? SpiderMultipartRequest,
            let data = multipart.multipartBody()?.data {
            
            if let string = String(data: data, encoding: .utf8) {
                curl += "-d \"\(string)\" \\\n"
            }
            else {
                curl += "-d <data: \(data)> \\\n"
            }
            
        }
        else {
            
            // Parameters
            
            if let params = parameters {
                for (key, value) in params {
                    curl += "-d \"\(key)=\(value)\" \\\n"
                }
            }
            
        }
        
        // Trim last backslash & newline
        // Print
        
        let final = String(curl.dropLast(2))
        print("\n\(final)\n")
        
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
        let params = parameters?.jsonString() ?? "none"
        let className = String(describing: type(of: self))
        
        var string = "<\(className) - method: \(method), baseUrl: \(baseUrl), path: \(path), auth: \(authString), params: \(params)"
        
        if let files = (self as? SpiderMultipartRequest)?.files {
            string += ", files: \(files.count)"
        }
        
        string += ">"
        return string
        
    }
    
    public var debugDescription: String {
        return description
    }
    
}
