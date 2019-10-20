//
//  Spider.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/22/18.
//

import Foundation

public class Spider {
    
    public var baseUrl: URLConvertible?
    public var authorization: RequestAuth?
    // TODO: Error providers: [ResponseErrorProvider]
    public var debugEnabled: Bool = false
    
    private var builder: RequestBuilder!
    private var session = URLSession.shared
    
    public static let web: Spider = Spider()
    
    @discardableResult
    public static func web(baseUrl: URLConvertible?, authorization: RequestAuth?) -> Spider {
        
        let web = Spider.web
        web.baseUrl = baseUrl
        web.authorization = authorization
        return web
        
    }
    
    public convenience init(baseUrl: URLConvertible?, authorization: RequestAuth?) {
        
        self.init()
        self.baseUrl = baseUrl
        self.authorization = authorization
        
    }
    
    public init() {
        
        self.builder = RequestBuilder(spider: self)
        
    }
    
    // MARK: Perform
    
    public func perform(_ request: Request) -> RequestWorker {
        
        return RequestWorker(
            request: request,
            builder: self.builder,
            session: self.session,
            debugEnabled: self.debugEnabled
        )
        
    }
    
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
    
    public func multipart(method: HTTPMethod = .post,
                          path: String,
                          parameters: JSON? = nil,
                          files: [MultipartFile],
                          authorization: RequestAuth? = nil) -> RequestWorker {
        
        // TODO: This
        return RequestWorker(error: SpiderError.badUrl)
        
    }
    
}
