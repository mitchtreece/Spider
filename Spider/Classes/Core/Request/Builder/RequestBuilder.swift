//
//  RequestBuilder.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/24/18.
//

import Foundation

internal class RequestBuilder {
    
    internal weak var spider: Spider?
    
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
        
        if let contentType = request.header.contentType?.value(for: request) {
            urlRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        }
        
        var acceptString: String?
        request.header.acceptTypes?.forEach { (type) in
            let value = type.value(for: request)
            acceptString = (acceptString == nil) ? value : "\(acceptString!), \(value)"
        }
        
        urlRequest.setValue(acceptString, forHTTPHeaderField: "Accept")
        
        for (key, value) in request.header.otherFields {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        // Authorization
        
        if let auth = request.authorization {
            urlRequest.setValue(auth.headerValue, forHTTPHeaderField: auth.field)
        }
        else if let sharedAuth = spider?.authorization {
            
            urlRequest.setValue(sharedAuth.headerValue, forHTTPHeaderField: sharedAuth.field)
            request.authorization = sharedAuth
            
        }
        
        return urlRequest
        
    }
    
}
