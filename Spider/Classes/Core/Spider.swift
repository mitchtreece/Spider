//
//  Spider.swift
//  Pods
//
//  Created by Mitch Treece on 12/13/16.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

public typealias SpiderResponse = (req: SpiderRequest, res: URLResponse?, data: Any?, err: Error?)
public typealias SpiderRequestCompletion = (SpiderResponse)->()

public class Spider {
    
    public static let web = Spider()
    
    public var baseUrl: String?
    public var requestSerializer: RequestSerializer = JSONRequestSerializer()
    public var responseSerializer: ResponseSerializer = JSONResponseSerializer()
    public var authorization: SpiderAuth?
    public var isDebugModeEnabled: Bool = false
    
    private var session = URLSession.shared
    
    @discardableResult
    public static func web(withBaseUrl baseUrl: String, auth: SpiderAuth? = nil) -> Spider {
        
        let web = Spider.web
        web.baseUrl = baseUrl
        web.authorization = auth
        return web
        
    }
    
    public convenience init(baseUrl: String?, auth: SpiderAuth? = nil) {
        
        self.init()
        self.baseUrl = baseUrl
        self.authorization = auth
        
    }
    
    public init() {
        
    }
    
    // MARK: Request Building
    
    internal func url(for request: SpiderRequest) -> String {
        
        if let base = baseUrl {
            return "\(base)\(request.path)"
        }
        
        return request.path
        
    }
    
    internal func requestSerializer(for request: SpiderRequest) -> RequestSerializer {
        
        if let serializer = request.requestSerializer {
            return serializer
        }
        
        return self.requestSerializer
        
    }
    
    internal func responseSerializer(for request: SpiderRequest) -> ResponseSerializer {
        
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
        
        guard let url = URL(string: url(for: request)) else { return nil }
        
        var req = URLRequest(url: url)
        req.httpMethod = request.method.rawValue
        req.httpBody = requestSerializer(for: request).serialization(of: request.parameters)
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
    
    public func perform(_ request: SpiderRequest, withCompletion completion: @escaping SpiderRequestCompletion) {
        
        guard let req = urlRequest(from: request) else {
            let response = SpiderResponse(request, nil, nil, SpiderError.badRequest)
            completion(response)
            return
        }
        
        debugPrint("Sending --> \(request)")
        
        session.dataTask(with: req as URLRequest) { (data, res, err) in
            let _data = self.responseSerializer(for: request).serialization(of: data) ?? (data as Any)
            let response: SpiderResponse = (request, res, _data, err)
            completion(response)
        }.resume()
                
    }
    
    public func get(_ path: String, parameters: Any? = nil, auth: SpiderAuth? = nil, completion: @escaping SpiderRequestCompletion) {
        
        let request = SpiderRequest(method: .get, path: path, parameters: parameters, auth: auth)
        perform(request, withCompletion: completion)
        
    }
    
    public func post(_ path: String, parameters: Any? = nil, auth: SpiderAuth? = nil, completion: @escaping SpiderRequestCompletion) {
        
        let request = SpiderRequest(method: .post, path: path, parameters: parameters, auth: auth)
        perform(request, withCompletion: completion)
        
    }
    
    public func put(_ path: String, parameters: Any? = nil, auth: SpiderAuth? = nil, completion: @escaping SpiderRequestCompletion) {
        
        let request = SpiderRequest(method: .put, path: path, parameters: parameters, auth: auth)
        perform(request, withCompletion: completion)
        
    }
    
    public func patch(_ path: String, parameters: Any? = nil, auth: SpiderAuth? = nil, completion: @escaping SpiderRequestCompletion) {
        
        let request = SpiderRequest(method: .patch, path: path, parameters: parameters, auth: auth)
        perform(request, withCompletion: completion)
        
    }
    
    public func delete(_ path: String, parameters: Any? = nil, auth: SpiderAuth? = nil, completion: @escaping SpiderRequestCompletion) {
        
        let request = SpiderRequest(method: .delete, path: path, parameters: parameters, auth: auth)
        perform(request, withCompletion: completion)
        
    }
    
    // MARK: Debug
    
    private func debugPrint(_ msg: String) {
        
        guard isDebugModeEnabled == true else { return }
        print(msg)
        
    }
    
}
