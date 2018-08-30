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
    
    internal func url<T: Serializable>(for request: Request<T>) -> URLConvertible {
        
        if let base = spider?.baseUrl, let baseString = base.urlString {
            return "\(baseString)\(request.path)"
        }
        
        return request.path
        
    }
    
    internal func urlRequest<T: Serializable>(for request: Request<T>) -> URLRequest? {
        
        // Request
        
        guard let url = url(for: request).url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.value
        urlRequest.httpBody = request.body.data
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
        
        if let auth = request.auth {
            urlRequest.setValue(auth.value, forHTTPHeaderField: auth.field)
        }
        else if let sharedAuth = spider?.auth {
            
            urlRequest.setValue(sharedAuth.value, forHTTPHeaderField: sharedAuth.field)
            request.auth = sharedAuth
            
        }
        
        return urlRequest
        
    }
    
}
