//
//  Spider.swift
//  Pods
//
//  Created by Mitch Treece on 12/13/16.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation
import AFNetworking

public typealias SpiderResponse = (res: URLResponse?, data: Any?, err: Error?)
public typealias SpiderRequestCompletion = (SpiderResponse) -> ()

public class Spider {
    
    public static let web = Spider()
    
    public var baseUrl: String?
    public var authorization: SpiderAuth?
    
    @discardableResult
    public static func web(withBaseUrl baseUrl: String, auth: SpiderAuth? = nil) -> Spider {
        
        let web = Spider.web
        web.baseUrl = baseUrl
        web.authorization = auth
        return web
        
    }
    
    public init() {
        //
    }
    
    public convenience init(baseUrl: String?, auth: SpiderAuth? = nil) {
        
        self.init()
        self.baseUrl = baseUrl
        self.authorization = auth
        
    }
    
    // MARK: Request Building
    
    internal func request(from request: SpiderRequest, session: AFHTTPSessionManager) -> NSMutableURLRequest? {
        
        let urlString = baseUrlString(from: request) ?? request.path
        let req = session.requestSerializer.request(withMethod: request.method.rawValue, urlString: urlString, parameters: request.parameters, error: nil)
        
        // Accept
        
        var accept: String?
        request.header.acceptStringify()?.forEach { (type) in
            accept = (accept == nil) ? type : "\(accept!), \(type)"
        }
        req.setValue(accept, forHTTPHeaderField: SpiderConstants.RequestAcceptType.headerField)
        
        // Other
        
        for (key, value) in request.header.other {
            req.setValue(value, forHTTPHeaderField: key)
        }
        
        return req
        
    }
    
    internal func baseUrlString(from request: SpiderRequest) -> String? {
        
        if let requestUrl = request.baseUrl {
            return requestUrl
        }
        else if let sharedUrl = baseUrl {
            return sharedUrl
        }
        
        return nil
        
    }
    
    internal func session(withBaseUrl baseUrl: URL?, acceptableContentTypes: [String]? = nil) -> AFHTTPSessionManager {
        
        let session = AFHTTPSessionManager(baseURL: baseUrl)
        session.requestSerializer = AFJSONRequestSerializer()
        session.responseSerializer = responseSerializer(acceptableContentTypes: acceptableContentTypes)
        return session
        
    }
    
    internal func responseSerializer(acceptableContentTypes: [String]?) -> AFHTTPResponseSerializer {
        
        let serializer = AFHTTPResponseSerializer()
        
        if let acceptTypes = acceptableContentTypes {
            serializer.acceptableContentTypes = Set(acceptTypes)
        }
        else {
            serializer.acceptableContentTypes = nil
        }
        
        return serializer
        
    }
    
    // MARK: Authorization
    
    internal func authorize(request: NSMutableURLRequest, with auth: SpiderAuth?) {
        
        if let auth = auth {
            request.setValue(auth.value, forHTTPHeaderField: auth.headerField)
        }
        else if let sharedAuth = self.authorization {
            request.setValue(sharedAuth.value, forHTTPHeaderField: sharedAuth.headerField)
        }
        
    }
    
    // MARK: Request Execution
    
    public func perform(_ request: SpiderRequest, withCompletion completion: @escaping SpiderRequestCompletion) {
        
        var baseUrl: URL?
        if let baseUrlString = baseUrlString(from: request), let url = URL(string: baseUrlString) {
            baseUrl = url
        }
        
        let accept = request.header.acceptStringify()
        let session = self.session(withBaseUrl: baseUrl, acceptableContentTypes: accept)
        
        guard let req = self.request(from: request, session: session) else {
            let response = SpiderResponse(nil, nil, SpiderError.badRequest)
            completion(response)
            return
        }
        
        authorize(request: req, with: request.auth)
        session.dataTask(with: req as URLRequest, completionHandler: completion).resume()
        
    }
    
    public func get(_ path: String, parameters: Any? = nil, auth: SpiderAuth? = nil, completion: @escaping SpiderRequestCompletion) {
        
        let request = SpiderRequest(method: .get, baseUrl: nil, path: path, parameters: parameters, auth: auth)
        perform(request, withCompletion: completion)
        
    }
    
    public func post(_ path: String, parameters: Any? = nil, auth: SpiderAuth? = nil, completion: @escaping SpiderRequestCompletion) {
        
        let request = SpiderRequest(method: .post, baseUrl: nil, path: path, parameters: parameters, auth: auth)
        perform(request, withCompletion: completion)
        
    }
    
    public func put(_ path: String, parameters: Any? = nil, auth: SpiderAuth? = nil, completion: @escaping SpiderRequestCompletion) {
        
        let request = SpiderRequest(method: .put, baseUrl: nil, path: path, parameters: parameters, auth: auth)
        perform(request, withCompletion: completion)
        
    }
    
    public func patch(_ path: String, parameters: Any? = nil, auth: SpiderAuth? = nil, completion: @escaping SpiderRequestCompletion) {
        
        let request = SpiderRequest(method: .patch, baseUrl: nil, path: path, parameters: parameters, auth: auth)
        perform(request, withCompletion: completion)
        
    }
    
    public func delete(_ path: String, parameters: Any? = nil, auth: SpiderAuth? = nil, completion: @escaping SpiderRequestCompletion) {
        
        let request = SpiderRequest(method: .delete, baseUrl: nil, path: path, parameters: parameters, auth: auth)
        perform(request, withCompletion: completion)
        
    }
    
}
