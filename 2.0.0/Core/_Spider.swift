//
//  _Spider.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/22/18.
//

import Foundation

@objc public class _Spider: NSObject {
    
    public var baseUrl: URLConvertible?
    public var auth: RequestAuth?
    public var isDebugMode: Bool = false
    private var session = URLSession.shared
    
    public static let web = _Spider()
    
    @discardableResult
    public static func web(baseUrl: URLConvertible?, auth: RequestAuth?) -> _Spider {
        
        let web = _Spider.web
        web.baseUrl = baseUrl
        web.auth = auth
        return web
        
    }
    
    public convenience init(baseUrl: URLConvertible?, auth: RequestAuth?) {
        
        self.init()
        self.baseUrl = baseUrl
        self.auth = auth
        
    }
    
    public override init() {
        super.init()
    }
    
    // MARK: Request execution
    
    public func perform(_ request: Request, completion: @escaping Request.Completion) {
        // TODO
    }
    
    @discardableResult
    public func performRequest(withMethod method: HTTPRequestMethodConvertible,
                               path: String,
                               parameters: JSON? = nil,
                               auth: RequestAuth? = nil,
                               completion: @escaping Request.Completion) -> Request {
        
        let request = Request(method: method, path: path, parameters: parameters, auth: auth)
        perform(request, completion: completion)
        return request
        
    }
    
    public func get(_ path: String,
                    queryParameters: JSON? = nil,
                    auth: RequestAuth? = nil,
                    completion: @escaping Request.Completion) -> Request {
        
        return performRequest(withMethod: "GET",
                              path: path,
                              parameters: queryParameters,
                              auth: auth,
                              completion: completion)
        
    }
    
    public func post(_ path: String,
                     parameters: JSON? = nil,
                     auth: RequestAuth? = nil,
                     completion: @escaping Request.Completion) -> Request {
        
        return performRequest(withMethod: "POST",
                              path: path,
                              parameters: parameters,
                              auth: auth,
                              completion: completion)
        
    }
    
    public func put(_ path: String,
                    parameters: JSON? = nil,
                    auth: RequestAuth? = nil,
                    completion: @escaping Request.Completion) -> Request {
        
        return performRequest(withMethod: "PUT",
                              path: path,
                              parameters: parameters,
                              auth: auth,
                              completion: completion)
        
    }
    
    public func patch(_ path: String,
                      parameters: JSON? = nil,
                      auth: RequestAuth? = nil,
                      completion: @escaping Request.Completion) -> Request {
        
        return performRequest(withMethod: "PATCH",
                              path: path,
                              parameters: parameters,
                              auth: auth,
                              completion: completion)
        
    }
    
    public func delete(_ path: String,
                       parameters: JSON? = nil,
                       auth: RequestAuth? = nil,
                       completion: @escaping Request.Completion) -> Request {
        
        return performRequest(withMethod: "DELETE",
                              path: path,
                              parameters: parameters,
                              auth: auth,
                              completion: completion)
        
    }
    
    @discardableResult
    public func multipart(method: HTTPRequestMethodConvertible = "POST",
                          path: String,
                          parameters: JSON? = nil,
                          files: [MultipartFile],
                          auth: RequestAuth? = nil,
                          completion: @escaping Request.Completion) -> Request {
        // TODO
    }
    
    // MARK: Debug
    
    private func _debugLogRequest(_ request: Request) {
        
        var string = "[\(request.method.httpRequestMethod)] \(request.path)"
        if let params = request.parameters {
            string += ", parameters: \(params.jsonString() ?? "some")"
        }
        
        _debugPrint(string)
        
    }
    
    private func _debugPrint(_ msg: String) {
        
        guard isDebugMode else { return }
        print("🌎 <Spider>: \(msg)")
        
    }
    
}
