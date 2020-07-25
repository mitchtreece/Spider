//
//  Spider.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/22/18.
//

import Foundation

/// `Spider` provides a simple & declarative way to execute web requests.
public class Spider {
    
    /// The shared base URL prepended to all request paths.
    ///
    /// If no base URL is provided, request paths are expected to be fully-qualified URLs.
    public var baseUrl: URLRepresentable?
    
    /// The shared authorization applied to all requests.
    public var authorization: RequestAuth?
    
    /// The shared headers applied to all requests.
    public var headers: Headers?
    
    /// The shared timeout applied to all requests.
    public var timeout: TimeInterval?
    
    /// The shared middlewares applied to all responses.
    public var middlewares: [Middleware]?
    
    /// Flag indicating if debug logging is enabled.
    public var isDebugEnabled: Bool = false {
        didSet {
            self.reachability?.isDebugEnabled = isDebugEnabled
        }
    }
    
    // The `Spider` instance's reachability monitor.
    public private(set) var reachability: ReachabilityMonitor?
    
    private var builder: RequestBuilder!
    private var session = URLSession.shared

    /// The shared `Spider` instance.
    public static let web: Spider = Spider()
    
    /// Fetches the shared `Spider` instance.
    /// - Parameter baseUrl: An optional global base URL.
    /// - Parameter authorization: An optional global authorization type.
    /// - Parameter reachabilityHostUrl: An optional host URL to use for reachability monitoring.
    /// - Returns: The configured shared `Spider` instance.
    @discardableResult
    public static func web(baseUrl: URLRepresentable?,
                           authorization: RequestAuth?,
                           reachabilityHostUrl: URLRepresentable?) -> Spider {
        
        let web = Spider.web
        web.baseUrl = baseUrl
        web.authorization = authorization
        web.reachability = ReachabilityMonitor(host: reachabilityHostUrl)
        return web
        
    }
    
    /// Initializes a `Spider` instance.
    /// - Parameter baseUrl: An optional shared base URL.
    /// - Parameter authorization: An optional shared authorization type.
    /// - Parameter reachabilityHostUrl: An optional host URL to use for reachability monitoring.
    /// - Returns: A configured `Spider` instance.
    public convenience init(baseUrl: URLRepresentable?,
                            authorization: RequestAuth?,
                            reachabilityHostUrl: URLRepresentable?) {
        
        self.init()
        self.baseUrl = baseUrl
        self.authorization = authorization
        self.reachability = ReachabilityMonitor(host: reachabilityHostUrl)
        
    }
    
    public init() {
        
        self.builder = RequestBuilder(spider: self)
        self.reachability = ReachabilityMonitor(host: nil)
        
    }
    
    // MARK: Perform
    
    /// Creates a request worker using a request.
    /// - Parameter request: The request.
    /// - Returns: A request worker.
    public func perform(_ request: Request) -> RequestWorker {
                
        return RequestWorker(
            request: request,
            builder: self.builder,
            middlewares: self.middlewares ?? [],
            session: self.session,
            isDebugEnabled: self.isDebugEnabled
        )
        
    }
    
    /// Creates a GET request worker.
    /// - Parameter path: The resource path to append to the shared base URL _or_
    /// a fully qualified URL (if no shared base URL is specified).
    ///     ```
    ///     "/users/12345"
    ///     "http://base.url/v1/users/12345"
    ///     ```
    /// - Parameter parameters: An optional parameter object to be query-encoded into the request path.
    /// - Parameter authorization: Optional authorization to use for this request.
    /// - Returns: A request worker.
    public func get(_ path: String,
                    parameters: JSON? = nil,
                    authorization: RequestAuth? = nil) -> RequestWorker {
        
        return perform(Request(
            method: .get,
            path: path,
            parameters: parameters,
            authorization: authorization
        ))
        
    }
    
    /// Creates a POST request worker.
    /// - Parameter path: The resource path to append to the shared base URL _or_
    /// a fully qualified URL (if no shared base URL is specified).
    ///     ```
    ///     "/users/12345"
    ///     "http://base.url/v1/users/12345"
    ///     ```
    /// - Parameter parameters: An optional parameter object to sent in the request body.
    /// - Parameter authorization: Optional authorization to use for this request.
    /// - Returns: A request worker.
    public func post(_ path: String,
                     parameters: JSON? = nil,
                     authorization: RequestAuth? = nil) -> RequestWorker {
        
        return perform(Request(
            method: .post,
            path: path,
            parameters: parameters,
            authorization: authorization
        ))
        
    }
    
    /// Creates a PUT request worker.
    /// - Parameter path: The resource path to append to the shared base URL _or_
    /// a fully qualified URL (if no shared base URL is specified).
    ///     ```
    ///     "/users/12345"
    ///     "http://base.url/v1/users/12345"
    ///     ```
    /// - Parameter parameters: An optional parameter object to sent in the request body.
    /// - Parameter authorization: Optional authorization to use for this request.
    /// - Returns: A request worker.
    public func put(_ path: String,
                    parameters: JSON? = nil,
                    authorization: RequestAuth? = nil) -> RequestWorker {
        
        return perform(Request(
            method: .put,
            path: path,
            parameters: parameters,
            authorization: authorization
        ))
        
    }
    
    /// Creates a PATCH request worker.
    /// - Parameter path: The resource path to append to the shared base URL _or_
    /// a fully qualified URL (if no shared base URL is specified).
    ///     ```
    ///     "/users/12345"
    ///     "http://base.url/v1/users/12345"
    ///     ```
    /// - Parameter parameters: An optional parameter object to sent in the request body.
    /// - Parameter authorization: Optional authorization to use for this request.
    /// - Returns: A request worker.
    public func patch(_ path: String,
                      parameters: JSON? = nil,
                      authorization: RequestAuth? = nil) -> RequestWorker {
        
        return perform(Request(
            method: .patch,
            path: path,
            parameters: parameters,
            authorization: authorization
        ))
        
    }
    
    /// Creates a DELETE request worker.
    /// - Parameter path: The resource path to append to the shared base URL _or_
    /// a fully qualified URL (if no shared base URL is specified).
    ///     ```
    ///     "/users/12345"
    ///     "http://base.url/v1/users/12345"
    ///     ```
    /// - Parameter parameters: An optional parameter object to sent in the request body.
    /// - Parameter authorization: Optional authorization to use for this request.
    /// - Returns: A request worker.
    public func delete(_ path: String,
                       parameters: JSON? = nil,
                       authorization: RequestAuth? = nil) -> RequestWorker {
        
        return perform(Request(
            method: .delete,
            path: path,
            parameters: parameters,
            authorization: authorization
        ))
        
    }
    
    /// Creates a multipart request worker.
    /// - Parameter method: The request's multipart HTTP method; _defaults to POST_.
    /// - Parameter path: The resource path to append to the shared base URL _or_
    /// a fully qualified URL (if no shared base URL is specified).
    ///     ```
    ///     "/users/12345"
    ///     "http://base.url/v1/users/12345"
    ///     ```
    /// - Parameter parameters: An optional parameter object to sent in the request body.
    /// - Parameter files: An array of files to be sent with the request.
    /// - Parameter authorization: Optional authorization to use for this request.
    /// - Returns: A request worker.
    public func multipart(method: MultipartRequest.Method = .post,
                          path: String,
                          parameters: JSON? = nil,
                          files: [MultipartFile],
                          authorization: RequestAuth? = nil) -> RequestWorker {

        return perform(MultipartRequest(
            method: method,
            path: path,
            parameters: parameters,
            files: files,
            authorization: authorization
        ))
        
    }
    
}
