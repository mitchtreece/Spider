//
//  Spider.swift
//  Pods
//
//  Created by Mitch Treece on 12/13/16.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

/**
 A typealias encapsulating all relevant response data.
 */
public typealias SpiderResponse = (req: SpiderRequest, res: URLResponse?, data: Any?, err: Error?)

/**
 A typealias representing a request completion handler.
 */
public typealias SpiderRequestCompletion = (SpiderResponse)->()

/**
 `Spider` provides a simple & configurable way to execute web requests.
 */
public class Spider {
    
    /**
     The shared `Spider` instance.
     */
    public static let web = Spider()
    
    /**
     The global base URL prepended to all request paths.
     
     If no base URL is provided, `Spider` will assume all request paths are fully-qualified URLs.
     */
    public var baseUrl: URLConvertible?
    
    /**
     The global serializer applied to all outgoing requests.
     
     Defaults to `JSONSerializer`
     */
    public var requestSerializer: Serializer = JSONSerializer()
    
    /**
     The global serializer applied to all incoming responses.
     
     Defaults to `JSONSerializer`
     */
    public var responseSerializer: Serializer = JSONSerializer()
    
    /**
     The global authorization applied to all outgoing requests.
     */
    public var authorization: SpiderAuth?
    
    /**
     Boolean indicating wether various debug options are enabled.
     */
    public var isDebugModeEnabled: Bool = false
    
    private var session = URLSession.shared
    
    /**
     - Parameter baseUrl: An optional global base URL.
     - Parameter auth: An optional global authorization type.
     - Returns: The shared `Spider` instance with an optional base URL & authorization type.
     */
    @discardableResult
    public static func web(withBaseUrl baseUrl: URLConvertible?, auth: SpiderAuth? = nil) -> Spider {
        
        let web = Spider.web
        web.baseUrl = baseUrl
        web.authorization = auth
        return web
        
    }
    
    /**
     Initializes a new `Spider` instance with an optional base URL & authorization type.
     - Parameter baseUrl: An optional global base URL.
     - Parameter auth: An optional global authorization type.
     */
    public convenience init(baseUrl: URLConvertible?, auth: SpiderAuth? = nil) {
        
        self.init()
        self.baseUrl = baseUrl
        self.authorization = auth
        
    }
    
    /**
     Initializes a new `Spider` instance.
     */
    public init() {
        
    }
    
    // MARK: Request Building
    
    internal func url(for request: SpiderRequest) -> URLConvertible {
        
        if let base = baseUrl, let baseUrlString = base.urlString {
            return "\(baseUrlString)\(request.path)"
        }
        
        return request.path
        
    }
    
    internal func requestSerializer(for request: SpiderRequest) -> Serializer {
        
        if let serializer = request.requestSerializer {
            return serializer
        }
        
        return self.requestSerializer
        
    }
    
    internal func responseSerializer(for request: SpiderRequest) -> Serializer {
        
        if let serializer = request.responseSerializer {
            return serializer
        }
        
        return self.responseSerializer
        
    }
    
    internal func urlRequest(from request: SpiderRequest) -> URLRequest? {
        
        // Set request's base url if needed
        
        if let baseUrl = self.baseUrl {
            request.baseUrl = baseUrl
        }
        
        // Create request
        
        guard let url = url(for: request).url else { return nil }
        
        var req = URLRequest(url: url)
        req.httpMethod = request.method.rawValue
        req.httpBody = requestSerializer(for: request).data(from: request.parameters)
        req.timeoutInterval = request.timeout ?? 60
        req.cachePolicy = request.cachePolicy ?? .useProtocolCachePolicy
        req.allowsCellularAccess = request.allowsCellularAccess ?? true
        
        // Header
        
        var accept: String?
        request.header.acceptStringify()?.forEach { (type) in
            accept = (accept == nil) ? type : "\(accept!), \(type)"
        }
        req.setValue(accept, forHTTPHeaderField: SpiderConstants.Request.headerAcceptField)
        
        for (key, value) in request.header.other {
            req.setValue(value, forHTTPHeaderField: key)
        }
        
        // Authorization
        
        if let auth = request.auth {
            req.setValue(auth.value, forHTTPHeaderField: auth.headerField)
        }
        else if let sharedAuth = self.authorization {
            req.setValue(sharedAuth.value, forHTTPHeaderField: sharedAuth.headerField)
        }
        
        return req
        
    }
    
    // MARK: Request Execution
    
    /**
     Performs a `SpiderRequest` with a given completion handler.
     - Parameter request: The `SpiderRequest` to perform.
     - Parameter completion: The completion handler.
     */
    public func perform(_ request: SpiderRequest, withCompletion completion: @escaping SpiderRequestCompletion) {
        
        guard let req = urlRequest(from: request) else {
            let response = SpiderResponse(request, nil, nil, SpiderError.badRequest)
            completion(response)
            return
        }
        
        _debugLogRequest(request)
        
        request.state = .working
        
        session.dataTask(with: req as URLRequest) { (data, res, err) in
            
            // TODO: Serializers should be able to infer concrete types so we can pass them back instead of `Any`.
            
            request.state = .finished
            
            let responseSerializer = self.responseSerializer(for: request)
            let _data = responseSerializer.object(from: data) ?? (data as Any)
            let response: SpiderResponse = (request, res, _data, err)
            completion(response)
            
        }.resume()
                
    }
    
    /**
     Performs a GET request with various configuration options & a completoin handler.
     - Parameter path: The endpoint path to append to the global base URL **or** a fully qualified URL (if no global base URL is specified).
        ```
        "/users/12345"
        "http://base.url/v1/users/12345"
        ```
     - Parameter parameters: An optional param object to be passed along with the request.
     - Parameter auth: An optional authorization type to use for this request. This will _override_ Spider's global authorization type. If no authorization type is provided, the request will fallback to Spider's global authorization type.
     - Parameter completion: The completion handler.
     - Returns: The underlying `SpiderRequest` object.
     */
    @discardableResult
    public func get(_ path: String, parameters: Any? = nil, auth: SpiderAuth? = nil, completion: @escaping SpiderRequestCompletion) -> SpiderRequest {
        
        let request = SpiderRequest(method: .get, path: path, parameters: parameters, auth: auth)
        perform(request, withCompletion: completion)
        return request
        
    }
    
    /**
     Performs a POST request with various configuration options & a completoin handler.
     - Parameter path: The endpoint path to append to the global base URL **or** a fully qualified URL (if no global base URL is specified).
     ```
     "/users/12345"
     "http://base.url/v1/users/12345"
     ```
     - Parameter parameters: An optional param object to be passed along with the request.
     - Parameter auth: An optional authorization type to use for this request. This will _override_ Spider's global authorization type. If no authorization type is provided, the request will fallback to Spider's global authorization type.
     - Parameter completion: The completion handler.
     - Returns: The underlying `SpiderRequest` object.
     */
    @discardableResult
    public func post(_ path: String, parameters: Any? = nil, auth: SpiderAuth? = nil, completion: @escaping SpiderRequestCompletion) -> SpiderRequest {
        
        let request = SpiderRequest(method: .post, path: path, parameters: parameters, auth: auth)
        perform(request, withCompletion: completion)
        return request
        
    }
    
    /**
     Performs a PUT request with various configuration options & a completoin handler.
     - Parameter path: The endpoint path to append to the global base URL **or** a fully qualified URL (if no global base URL is specified).
     ```
     "/users/12345"
     "http://base.url/v1/users/12345"
     ```
     - Parameter parameters: An optional param object to be passed along with the request.
     - Parameter auth: An optional authorization type to use for this request. This will _override_ Spider's global authorization type. If no authorization type is provided, the request will fallback to Spider's global authorization type.
     - Parameter completion: The completion handler.
     - Returns: The underlying `SpiderRequest` object.
     */
    @discardableResult
    public func put(_ path: String, parameters: Any? = nil, auth: SpiderAuth? = nil, completion: @escaping SpiderRequestCompletion) -> SpiderRequest {
        
        let request = SpiderRequest(method: .put, path: path, parameters: parameters, auth: auth)
        perform(request, withCompletion: completion)
        return request
        
    }
    
    /**
     Performs a PATCH request with various configuration options & a completoin handler.
     - Parameter path: The endpoint path to append to the global base URL **or** a fully qualified URL (if no global base URL is specified).
     ```
     "/users/12345"
     "http://base.url/v1/users/12345"
     ```
     - Parameter parameters: An optional param object to be passed along with the request.
     - Parameter auth: An optional authorization type to use for this request. This will _override_ Spider's global authorization type. If no authorization type is provided, the request will fallback to Spider's global authorization type.
     - Parameter completion: The completion handler.
     - Returns: The underlying `SpiderRequest` object.
     */
    @discardableResult
    public func patch(_ path: String, parameters: Any? = nil, auth: SpiderAuth? = nil, completion: @escaping SpiderRequestCompletion) -> SpiderRequest {
        
        let request = SpiderRequest(method: .patch, path: path, parameters: parameters, auth: auth)
        perform(request, withCompletion: completion)
        return request
        
    }
    
    /**
     Performs a DELETE request with various configuration options & a completoin handler.
     - Parameter path: The endpoint path to append to the global base URL **or** a fully qualified URL (if no global base URL is specified).
     ```
     "/users/12345"
     "http://base.url/v1/users/12345"
     ```
     - Parameter parameters: An optional param object to be passed along with the request.
     - Parameter auth: An optional authorization type to use for this request. This will _override_ Spider's global authorization type. If no authorization type is provided, the request will fallback to Spider's global authorization type.
     - Parameter completion: The completion handler.
     - Returns: The underlying `SpiderRequest` object.
     */
    @discardableResult
    public func delete(_ path: String, parameters: Any? = nil, auth: SpiderAuth? = nil, completion: @escaping SpiderRequestCompletion) -> SpiderRequest {
        
        let request = SpiderRequest(method: .delete, path: path, parameters: parameters, auth: auth)
        perform(request, withCompletion: completion)
        return request
        
    }
    
    // MARK: Debug
    
    private func _debugLogRequest(_ req: SpiderRequest) {
        
        var string = "[\(req.method.rawValue)] \(req.path)"
        if let params = req.parameters as? JSON {
            string += ", parameters: \(params.jsonString() ?? "some")"
        }
        
        _debugPrint(string)
        
    }
    
    private func _debugPrint(_ msg: String) {
        
        guard isDebugModeEnabled == true else { return }
        print("<Spider>: \(msg)")
        
    }
    
}
