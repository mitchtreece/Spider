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

public typealias WebToken = String
public typealias RequestCompletion = (URLResponse?, Any?, Error?) -> ()

public class Spider {
    
    public enum AuthType {
        case none
        case token
    }
    
    public static var web = Spider()
    
    public var baseUrl: URL?
    
    // public private(set) var accessToken: WebToken = ""
    
    @discardableResult
    public static func with(baseUrl: URL) -> Spider {
        
        let web = Spider.web
        web.baseUrl = baseUrl
        return web
        
    }
    
    private init() {
        //
    }
    
    public convenience init(baseUrl: URL?) {
        
        self.init()
        self.baseUrl = baseUrl
        
    }
    
    internal func authorize(request: NSMutableURLRequest, authType: AuthType = .token) {
        
        switch authType {
        case .none: break
        case .token: break
            
            // request.setValue(accessToken, forHTTPHeaderField: "x-access-token")
            // request.setValue("application/json", forHTTPHeaderField: "Accept")
            
        }
        
    }
    
    private func session(withBaseUrl url: URL?, acceptableContentTypes: [String]? = nil) -> AFHTTPSessionManager {
        
        let session = AFHTTPSessionManager(baseURL: url)
        
        // Request Serializer
        
        session.requestSerializer = AFJSONRequestSerializer()
        
        // Response Serializer
        
        let resSerializer = responseSerializer(acceptableContentTypes: acceptableContentTypes)
        session.responseSerializer = resSerializer
        
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
    
    private func request(from request: SpiderRequest, session: AFHTTPSessionManager) -> NSMutableURLRequest? {
        
        guard let baseUrl = self.baseUrl(from: request) else { return nil }
        
        let url = "\(baseUrl)\(request.path)"
        let req = session.requestSerializer.request(withMethod: request.method.rawValue, urlString: url, parameters: request.parameters, error: nil)
        
        // Accept
        
        var accept: String?
        request.header.acceptStringify().forEach { (type) in
            accept = (accept == nil) ? type : "\(accept!), \(type)"
        }
        req.setValue(accept, forHTTPHeaderField: "Accept")
        
        // Other
        
        for (key, value) in request.header.other {
            req.setValue(value, forHTTPHeaderField: key)
        }
        
        return req
        
    }
    
    private func baseUrl(from request: SpiderRequest) -> String? {
        
        if let requestUrl = request.baseUrl {
            return requestUrl
        }
        else if let sharedUrl = baseUrl {
            return String(describing: sharedUrl)
        }
        
        return nil
        
    }
    
    // MARK: Request Execution
    
    public func execute(_ request: SpiderRequest, withCompletion completion: @escaping RequestCompletion) {
        
        guard let baseUrlString = self.baseUrl(from: request), let baseUrl = URL(string: baseUrlString) else {
            print("no base url")
            return
        }
        
        let accept = request.header.acceptStringify()
        let session = self.session(withBaseUrl: baseUrl, acceptableContentTypes: accept)
        
        guard let req = self.request(from: request, session: session) else {
            print("Error fetching request")
            return
        }
        
        authorize(request: req, authType: request.auth)
        session.dataTask(with: req as URLRequest, completionHandler: completion).resume()
        
    }
    
    public func post(path: String, parameters: Any?, authType: AuthType = .none, completion: @escaping RequestCompletion) {
        
        let request = SpiderRequest(method: .post, baseUrl: nil, path: path, parameters: parameters, auth: authType)
        execute(request, withCompletion: completion)
        
    }
    
    public func get(path: String, parameters: Any?, authType: AuthType = .none, completion: @escaping RequestCompletion) {
        
        let request = SpiderRequest(method: .get, baseUrl: nil, path: path, parameters: parameters, auth: authType)
        execute(request, withCompletion: completion)
        
    }
    
    public func delete(path: String, parameters: Any?, authType: AuthType = .none, completion: @escaping RequestCompletion) {
        
        let request = SpiderRequest(method: .delete, baseUrl: nil, path: path, parameters: parameters, auth: authType)
        execute(request, withCompletion: completion)
        
    }
    
}
