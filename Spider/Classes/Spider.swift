//
//  Spider.swift
//  Pods
//
//  Created by Mitch Treece on 12/13/16.
//
//

import Foundation
import Alamofire
import AFNetworking

public typealias SpiderResponse = (res: URLResponse?, data: Any?, err: Error?)
public typealias SpiderRequestCompletion = (SpiderResponse) -> ()

public class Spider {
    
    public enum Authorization {
        case none
        case token(SpiderToken?)
    }
    
    public static var web = Spider()
    
    public var baseUrl: URL?
    public var authorization: Authorization?
    
    @discardableResult
    public static func web(withBaseUrl baseUrl: URL, auth: Authorization? = nil) -> Spider {
        
        let web = Spider.web
        web.baseUrl = baseUrl
        web.authorization = auth
        return web
        
    }
    
    public init() {
        //
    }
    
    public convenience init(baseUrl: URL?, auth: Authorization? = nil) {
        
        self.init()
        self.baseUrl = baseUrl
        self.authorization = auth
        
    }
    
    internal func authorize(request: NSMutableURLRequest, with auth: Authorization) {
        
        switch auth {
        case .none: break
        case .token(let token):
            
            if let token = token {
                request.setValue(token.value, forHTTPHeaderField: token.headerField)
            }
            else if let _auth = self.authorization {
                if case let Authorization.token(_token) = _auth, _token != nil {
                    request.setValue(_token!.value, forHTTPHeaderField: _token!.headerField)
                }
            }
            
        }
        
    }
    
    internal func session(withBaseUrl url: URL?, acceptableContentTypes: [String]? = nil) -> AFHTTPSessionManager {
        
        let session = AFHTTPSessionManager(baseURL: url)
        session.requestSerializer = AFJSONRequestSerializer()
        session.responseSerializer = responseSerializer(acceptableContentTypes: acceptableContentTypes)
        return session
        
    }
    
    private func responseSerializer(acceptableContentTypes: [String]?) -> AFHTTPResponseSerializer {
        
        let serializer = AFHTTPResponseSerializer()
        
        if let acceptTypes = acceptableContentTypes {
            serializer.acceptableContentTypes = Set(acceptTypes)
        }
        else {
            serializer.acceptableContentTypes = nil
        }
        
        return serializer
        
    }
    
    // MARK: Request Helpers
    
    internal func request(from request: SpiderRequest, session: AFHTTPSessionManager) -> NSMutableURLRequest? {
        
        var urlString = self.baseUrl(from: request) ?? request.path
        let req = session.requestSerializer.request(withMethod: request.method.rawValue, urlString: urlString, parameters: request.parameters, error: nil)
        
        // Accept
        
        var accept: String?
        request.header.acceptStringify()?.forEach { (type) in
            accept = (accept == nil) ? type : "\(accept!), \(type)"
        }
        req.setValue(accept, forHTTPHeaderField: "Accept")
        
        // Other
        
        for (key, value) in request.header.other {
            req.setValue(value, forHTTPHeaderField: key)
        }
        
        return req
        
    }
    
    internal func baseUrl(from request: SpiderRequest) -> String? {
        
        if let requestUrl = request.baseUrl {
            return requestUrl
        }
        else if let sharedUrl = baseUrl {
            return String(describing: sharedUrl)
        }
        
        return nil
        
    }
    
    // MARK: Request Execution
    
    public func perform(_ request: SpiderRequest, withCompletion completion: @escaping SpiderRequestCompletion) {
        
        var baseUrl: URL?
        if let baseUrlString = self.baseUrl(from: request), let url = URL(string: baseUrlString) {
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
    
    public func get(path: String, parameters: Any?, auth: Authorization = .none, completion: @escaping SpiderRequestCompletion) {
        
        let request = SpiderRequest(method: .get, baseUrl: nil, path: path, parameters: parameters, auth: auth)
        perform(request, withCompletion: completion)
        
    }
    
    public func post(path: String, parameters: Any?, auth: Authorization = .none, completion: @escaping SpiderRequestCompletion) {
        
        let request = SpiderRequest(method: .post, baseUrl: nil, path: path, parameters: parameters, auth: auth)
        perform(request, withCompletion: completion)
        
    }
    
    public func put(path: String, parameters: Any?, auth: Authorization = .none, completion: @escaping SpiderRequestCompletion) {
        
        let request = SpiderRequest(method: .put, baseUrl: nil, path: path, parameters: parameters, auth: auth)
        perform(request, withCompletion: completion)
        
    }
    
    public func patch(path: String, parameters: Any?, auth: Authorization = .none, completion: @escaping SpiderRequestCompletion) {
        
        let request = SpiderRequest(method: .patch, baseUrl: nil, path: path, parameters: parameters, auth: auth)
        perform(request, withCompletion: completion)
        
    }
    
    public func delete(path: String, parameters: Any?, auth: Authorization = .none, completion: @escaping SpiderRequestCompletion) {
        
        let request = SpiderRequest(method: .delete, baseUrl: nil, path: path, parameters: parameters, auth: auth)
        perform(request, withCompletion: completion)
        
    }
    
}
