//
//  Spider.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/22/18.
//

import Foundation

public class Spider {
    
    public var baseUrl: URLRepresentable?
    public var authorization: RequestAuth?
    
    public var isDebugEnabled: Bool = false {
        didSet {
            self.reachability?.isDebugEnabled = isDebugEnabled
        }
    }
    
    public private(set) var reachability: ReachabilityMonitor?
    
    private var builder: RequestBuilder!
    private var session = URLSession.shared

    public static let web: Spider = Spider()
    
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
    
    public func perform(_ request: Request) -> RequestWorker {
        
        request.spider = self
        
        return RequestWorker(
            request: request,
            builder: self.builder,
            session: self.session,
            isDebugEnabled: self.isDebugEnabled
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
