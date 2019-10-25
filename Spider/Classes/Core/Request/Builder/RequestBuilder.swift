//
//  RequestBuilder.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/24/18.
//

import Foundation

internal class RequestBuilder {
    
    internal weak var spider: Spider!
    
    internal init(spider: Spider) {
        self.spider = spider
    }
    
    internal func url(for request: Request) -> URLRepresentable {
        
        let path = request.queryEncodedPath ?? request.path
        
        if let base = self.spider?.baseUrl,
            let baseString = base.urlString {
            return "\(baseString)\(path)"
        }
        
        return path
        
    }
    
    internal func urlRequest(for request: Request) -> URLRequest? {
        
        guard let url = url(for: request).url else { return nil }
        
        // Request
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.value
        urlRequest.httpBody = request.body?.data
        urlRequest.timeoutInterval = request.timeout
        urlRequest.cachePolicy = request.cachePolicy
        urlRequest.allowsCellularAccess = request.allowsCellularAccess
        
        // Header
        
        for (key, value) in request.headers.dictionaryRepresentation(for: request, using: self.spider) {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        // Set shared auth if needed
        
        if let sharedAuth = self.spider.authorization, request.authorization == nil {
            request.authorization = sharedAuth
        }
        
        return urlRequest
        
    }
    
}
