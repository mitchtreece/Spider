//
//  Spider.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/22/18.
//

import Foundation

@objc public class Spider: NSObject {
    
    public var baseUrl: URLConvertible?
    public var auth: RequestAuth?
    public var isDebugMode: Bool = false
    
    internal var builder: RequestBuilder!
    internal var session = URLSession.shared
    
    public static let web = Spider()
    
    @discardableResult
    public static func web(baseUrl: URLConvertible?, auth: RequestAuth?) -> Spider {
        
        let web = Spider.web
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
        builder = RequestBuilder(spider: self)
        
    }
    
    // MARK: Request execution
    
    public func perform<T: Serializable>(_ request: Request<T>, completion: @escaping Request<T>.Completion) {
        
        guard let urlRequest = builder.urlRequest(for: request) else {
            return completion(nil, SpiderError.badUrl)
        }
        
        _debugLogRequest(request)
        
        request.state = .working
        
        session.dataTask(with: urlRequest) { (data, res, err) in
            
            if let err = err {
                
                var code: HTTPStatusCode = .none
                if let _code = (res as? HTTPURLResponse)?.statusCode {
                    code = HTTPStatusCode(rawValue: _code) ?? .none
                }
                
                return completion(nil, HTTPError(description: err.localizedDescription, statusCode: code, path: request.path))
                
            }
            
            guard let data = data else { return completion(nil, SpiderError.badData) }
            guard let value = T.serialized(from: data) as? T else { return completion(nil, SpiderError.serialization) }
            return completion(value, nil)
            
        }.resume()
        
    }
    
    @discardableResult
    public func performRequest<T: Serializable>(withMethod method: HTTPMethod,
                                                path: String,
                                                parameters: JSON? = nil,
                                                auth: RequestAuth? = nil,
                                                completion: @escaping Request<T>.Completion) -> Request<T> {
        
        let request = Request<T>(method: method, path: path, parameters: parameters, auth: auth)
        perform(request, completion: completion)
        return request
        
    }
    
    @discardableResult
    public func get<T: Serializable>(_ path: String,
                                     queryParameters: JSON? = nil,
                                     auth: RequestAuth? = nil,
                                     completion: @escaping Request<T>.Completion) -> Request<T> {
        
        return performRequest(withMethod: .get,
                              path: path,
                              parameters: queryParameters,
                              auth: auth,
                              completion: completion)
        
    }
    
    @discardableResult
    public func post<T: Serializable>(_ path: String,
                                      parameters: JSON? = nil,
                                      auth: RequestAuth? = nil,
                                      completion: @escaping Request<T>.Completion) -> Request<T> {
        
        return performRequest(withMethod: .post,
                              path: path,
                              parameters: parameters,
                              auth: auth,
                              completion: completion)
        
    }
    
    @discardableResult
    public func put<T: Serializable>(_ path: String,
                                     parameters: JSON? = nil,
                                     auth: RequestAuth? = nil,
                                     completion: @escaping Request<T>.Completion) -> Request<T> {
        
        return performRequest(withMethod: .put,
                              path: path,
                              parameters: parameters,
                              auth: auth,
                              completion: completion)
        
    }
    
    @discardableResult
    public func patch<T: Serializable>(_ path: String,
                                       parameters: JSON? = nil,
                                       auth: RequestAuth? = nil,
                                       completion: @escaping Request<T>.Completion) -> Request<T> {
        
        return performRequest(withMethod: .patch,
                              path: path,
                              parameters: parameters,
                              auth: auth,
                              completion: completion)
        
    }
    
    @discardableResult
    public func delete<T: Serializable>(_ path: String,
                                        parameters: JSON? = nil,
                                        auth: RequestAuth? = nil,
                                        completion: @escaping Request<T>.Completion) -> Request<T> {
        
        return performRequest(withMethod: .delete,
                              path: path,
                              parameters: parameters,
                              auth: auth,
                              completion: completion)
        
    }
    
    @discardableResult
    public func multipart<T: Serializable>(method: HTTPMethod = .post,
                                           path: String,
                                           parameters: JSON? = nil,
                                           files: [MultipartFile],
                                           auth: RequestAuth? = nil,
                                           completion: @escaping Request<T>.Completion) -> Request<T> {
        // TODO
        return Request(method: method, path: "", parameters: nil, auth: nil)
        
    }
    
    // MARK: Debug
    
    private func _debugLogRequest<T: Serializable>(_ request: Request<T>) {
        
        var string = "[\(request.method.value)] \(request.path)"
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
