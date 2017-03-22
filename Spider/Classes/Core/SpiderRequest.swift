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
    public private(set) var other = [String: String]()
    
    public init() {}
    
    // MARK: Public
    
    public func set(value: String, forHeaderField field: String) {
    
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
    
    public var method: Method
    public var baseUrl: String?
    public var path: String
    public var parameters: Any?
    public var auth: Spider.Authorization
    
    public var header = SpiderRequestHeader()
    
    public init(method: Method, baseUrl: String? = nil, path: String, parameters: Any? = nil, auth: Spider.Authorization = .none) {
        
        self.method = method
        self.baseUrl = baseUrl
        self.path = path
        self.parameters = parameters
        self.auth = auth
        
    }
    
}

extension SpiderRequest: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        
        var authString = "none"
        
        if case let .token(token) = auth {
            authString = "token"
            if let _token = token {
                authString += " {\n\t\theaderField: \(_token.headerField)\n\t\tvalue: \(_token.value)\n\t}"
            }
        }
        
        return "SpiderRequest {\n\tmethod: \(method.rawValue)\n\tbaseUrl: \(baseUrl)\n\tpath: \(path)\n\tauth: \(authString)\n\tparams: \(parameters)\n}"
        
    }
    
    public var debugDescription: String {
        return description
    }
    
}
