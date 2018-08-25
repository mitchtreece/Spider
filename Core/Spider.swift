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
    
    private var builder: RequestBuilder!
    private var session = URLSession.shared
    
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
    
    public func perform(_ request: Request, completion: @escaping Request.Completion) {
        
        guard let urlRequest = builder.urlRequest(for: request) else {
            let response = Response(request: request, urlResponse: nil, data: nil, error: Request.Error.bad(request))
            return completion(response)
        }
        
        _debugLogRequest(request)
        
        request.state = .working
        
        session.dataTask(with: urlRequest) { (data, res, err) in
            
            var httpError: HTTPError?
            
            if let err = err {
                
                var code: HTTPStatusCode = .none
                if let _code = (res as? HTTPURLResponse)?.statusCode {
                    code = HTTPStatusCode(rawValue: _code) ?? .none
                }
                
                httpError = HTTPError(description: err.localizedDescription, statusCode: code, path: request.path)
                
            }
            
            let response = Response(request: request, urlResponse: res, data: data, error: httpError)
            request.state = .finished(response)
            completion(response)
            
        }.resume()
        
    }
    
    @discardableResult
    public func performRequest(withMethod method: HTTPMethod,
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
        
        return performRequest(withMethod: .get,
                              path: path,
                              parameters: queryParameters,
                              auth: auth,
                              completion: completion)
        
    }
    
    public func post(_ path: String,
                     parameters: JSON? = nil,
                     auth: RequestAuth? = nil,
                     completion: @escaping Request.Completion) -> Request {
        
        return performRequest(withMethod: .post,
                              path: path,
                              parameters: parameters,
                              auth: auth,
                              completion: completion)
        
    }
    
    public func put(_ path: String,
                    parameters: JSON? = nil,
                    auth: RequestAuth? = nil,
                    completion: @escaping Request.Completion) -> Request {
        
        return performRequest(withMethod: .put,
                              path: path,
                              parameters: parameters,
                              auth: auth,
                              completion: completion)
        
    }
    
    public func patch(_ path: String,
                      parameters: JSON? = nil,
                      auth: RequestAuth? = nil,
                      completion: @escaping Request.Completion) -> Request {
        
        return performRequest(withMethod: .patch,
                              path: path,
                              parameters: parameters,
                              auth: auth,
                              completion: completion)
        
    }
    
    public func delete(_ path: String,
                       parameters: JSON? = nil,
                       auth: RequestAuth? = nil,
                       completion: @escaping Request.Completion) -> Request {
        
        return performRequest(withMethod: .delete,
                              path: path,
                              parameters: parameters,
                              auth: auth,
                              completion: completion)
        
    }
    
    @discardableResult
    public func multipart(method: HTTPMethod = .post, // TODO: Limit this to post || put
                          path: String,
                          parameters: JSON? = nil,
                          files: [MultipartFile],
                          auth: RequestAuth? = nil,
                          completion: @escaping Request.Completion) -> Request {
        // TODO
        return Request(method: method, path: "", parameters: nil, auth: nil)
        
    }
    
    // MARK: Debug
    
    private func _debugLogRequest(_ request: Request) {
        
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
