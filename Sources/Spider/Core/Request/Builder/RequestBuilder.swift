//
//  RequestBuilder.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/24/18.
//

import Espresso

internal class RequestBuilder {
    
    internal weak var spider: Spider!
    
    internal init(spider: Spider) {
        self.spider = spider
    }
    
    internal func url(for request: Request) -> URLRepresentable {
        
        let path = request.queryEncodedPath ?? request.path
        
        if let base = self.spider?.baseUrl,
            let baseString = base.asUrlString() {
            return "\(baseString)\(path)"
        }
        
        return path
        
    }
    
    internal func urlRequest(for request: Request) -> URLRequest? {
        
        guard let url = url(for: request).asUrl() else { return nil }
        
        // Request
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.value
        urlRequest.httpBody = request.body?.data
        urlRequest.timeoutInterval = request.timeout
        urlRequest.cachePolicy = request.cachePolicy
        urlRequest.allowsCellularAccess = request.allowsCellularAccess
        urlRequest.httpShouldHandleCookies = request.shouldHandleCookies
        
        // Headers

        let baseHeaders = self.spider.headers ?? Headers()
        var headers = request.ignoreSharedHeaders ? request.headers : baseHeaders.merged(with: request.headers)
        
        let jsonHeaders = headers.jsonifyAndPrepare(
            for: request,
            using: self.spider
        )

        for (key, value) in jsonHeaders {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        // Set the request headers to our
        // updated (merged) headers
        
        request.headers = headers
        
        // Set shared auth if needed
        
        if let sharedAuth = self.spider.authorization,
            !request.ignoreSharedAuthorization,
            request.authorization == nil {
            request.authorization = sharedAuth
        }
        
        // Set shared timeout if needed
        
        if let sharedTimeout = self.spider.timeout,
            !request.ignoreSharedTimeout {
            request.timeout = sharedTimeout
        }
        
        return urlRequest
        
    }
    
}
