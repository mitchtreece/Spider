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
    
    public init() {
        //
    }
    
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
            case .application_json: strings.append(SpiderConstants.RequestAcceptType.application_json)
            case .application_javascript: strings.append(SpiderConstants.RequestAcceptType.application_javascript)
            case .text_json: strings.append(SpiderConstants.RequestAcceptType.text_json)
            case .text_javascript: strings.append(SpiderConstants.RequestAcceptType.text_javascript)
            case .text_html: strings.append(SpiderConstants.RequestAcceptType.text_html)
            case .text_plain: strings.append(SpiderConstants.RequestAcceptType.text_plain)
            case .image_jpeg: strings.append(SpiderConstants.RequestAcceptType.image_jpeg)
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
    public var auth: Spider.AuthType
    
    public var header = SpiderRequestHeader()
    
    public init(method: Method, baseUrl: String? = nil, path: String, parameters: Any? = nil, auth: Spider.AuthType = .none) {
        
        self.method = method
        self.baseUrl = baseUrl
        self.path = path
        self.parameters = parameters
        self.auth = auth
        
    }
    
}

extension SpiderRequest: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        
        var authString = ""
        
        if case .none = auth {
            authString = "none"
        }
        else if case let .basic(ba) = auth {
            authString = "basic"
            if let _ba = ba {
                authString += " {\n\t\tfield: \(_ba.headerField())\n\t\traw: \(_ba.username):\(_ba.password)\n\t\tencoded: \(_ba.rawValue)\n\t}"
            }
        }
        else if case let .token(token) = auth {
            authString = "token"
            if let _token = token {
                authString += " {\n\t\tfield: \(_token.headerField())\n\t\tvalue: \(_token.value)\n\t}"
            }
        }
        
        let base = baseUrl ?? "none"
        let params = debugParameterString() ?? "none"
        
        return "<SpiderRequest> {\n\tmethod: \(method.rawValue)\n\tbaseUrl: \(base)\n\tpath: \(path)\n\tauth: \(authString)\n\tparams: \(params)\n}"
        
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
