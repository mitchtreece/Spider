//
//  SpiderRequest.swift
//  Pods
//
//  Created by Mitch Treece on 12/14/16.
//
//

import Foundation

public class SpiderRequestHeader {
    
    public enum AcceptType {
        case application_json
        case application_javascript
        case text_json
        case image_jpeg
        case custom(String)
    }
    
    public var accept: [AcceptType]?
    public private(set) var other = [String: String]()
    
    public init() {
        
    }
    
    // MARK: Public
    
    public func set(value: String, forHeaderField field: String) {
    
        other[field] = value
        
    }
    
    // MARK: Private
    
    internal func acceptStringify() -> [String] {
        
        guard let accept = accept else { return [] }
        
        var strings = [String]()
        
        for type in accept {
            switch type {
            case .application_json: strings.append("application/json")
            case .application_javascript: strings.append("application/javascript")
            case .text_json: strings.append("text/json")
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
        case delete = "DELETE"
    }
    
    public enum AuthType {
        case none
        case token(SpiderToken?)
    }
    
    public var method: Method
    public var baseUrl: String?
    public var path: String
    public var parameters: Any?
    public var auth: AuthType
    
    public var header = SpiderRequestHeader()
    
    public init(method: Method = .get, baseUrl: String? = nil, path: String, parameters: Any?, auth: AuthType = .none) {
        
        self.method = method
        self.baseUrl = baseUrl
        self.path = path
        self.parameters = parameters
        self.auth = auth
        
    }
    
}
