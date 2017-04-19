//
//  SpiderRequest.swift
//  Pods
//
//  Created by Mitch Treece on 12/14/16.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

public class SpiderRequestHeader {
    
    public enum AcceptType {
        case application_json
        case application_javascript
        case text_json
        case text_javascript
        case text_html
        case text_plain
        case image_jpeg
        case custom(String)
    }
    
    public var accept: [AcceptType]?
    internal var other = [String: String]()
    
    // MARK: Public
    
    public func set(value: String, forField field: String) {
    
        other[field] = value
        
    }
    
    // MARK: Internal
    
    internal func acceptStringify() -> [String]? {
        
        guard let accept = accept else { return nil }
        
        var strings = [String]()
        
        for type in accept {
            switch type {
            case .application_json: strings.append("application/json")
            case .application_javascript: strings.append("application/javascript")
            case .text_json: strings.append("text/json")
            case .text_javascript: strings.append("text/javascript")
            case .text_html: strings.append("text/html")
            case .text_plain: strings.append("text/plain")
            case .image_jpeg: strings.append("image/jpeg")
            case .custom(let _type): strings.append(_type)
            }
        }
        
        return strings
        
    }
    
}

public class SpiderRequest {
    
    public enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    internal(set) var baseUrl: String?
    public var requestSerializer: RequestSerializer?
    public var responseSerializer: ResponseSerializer?
    
    public var header = SpiderRequestHeader()
    public var method: Method
    public var path: String
    public var parameters: Any?
    public var auth: SpiderAuth?
    
    // URLRequest
    
    public var timeout: TimeInterval?
    public var cachePolicy: NSURLRequest.CachePolicy?
    public var allowsCellularAccess: Bool?
    
    public init(method: Method, path: String, parameters: Any? = nil, auth: SpiderAuth? = nil) {
        
        self.method = method
        self.path = path
        self.parameters = parameters
        self.auth = auth
        
    }
    
}

extension SpiderRequest: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        
        var authString = "none"
        
        if let auth = auth {
            
            switch auth {
            case is BasicAuth: authString = "basic"
            case is TokenAuth: authString = "token"
            default: break
            }
            
            authString += " {\n\t\tfield: \(auth.headerField)\n\t\tvalue: \"\(auth.value)\"\n\t}"
            
        }
        
        let baseUrl = self.baseUrl ?? "none"
        let params = debugParameterString() ?? "none"
        return "<SpiderRequest>: {\n\tmethod: \(method.rawValue)\n\tbaseUrl: \(baseUrl)\n\tpath: \(path)\n\tauth: \(authString)\n\tparams: \(params)\n}"
        
    }
    
    public var debugDescription: String {
        return description
    }
    
    private func debugParameterString() -> String? {
    
        var params: String = ""
        
        if let obj = parameters as? [String: Any] {
            
            params = "{"
            
            for (key, value) in obj {
                let _value = (value is String) ? "\"\(value)\"" : value
                params += "\n\t\t\"\(key)\": \(_value)"
            }
            
            params += "\n\t}"
            return params
            
        }
        else if let obj = parameters as? [[String: Any]] {
            
            params = "["
            
            for dict in obj {
                params += "\n\t\t\(dict)"
            }
            
            params += "\n\t]"
            return params
            
        }
        else if let obj = parameters {
            
            return "\(obj)"
            
        }
        
        return nil
        
    }
    
}
