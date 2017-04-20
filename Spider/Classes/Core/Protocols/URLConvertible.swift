//
//  URLConvertible.swift
//  Pods
//
//  Created by Mitch Treece on 4/19/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

public protocol URLConvertible {
    
    var url: URL? { get }
    var urlString: String { get }
    var queryParameters: [String: String] { get }
    
}

public extension URLConvertible {
    
    public var queryParameters: [String: String] {
        
        var params = [String: String]()
        
        self.url?.query?.components(separatedBy: "&").forEach { (component) in
            let pair = component.components(separatedBy: "=")
            if pair.count == 2 {
                let key = pair[0]
                let value = pair[1].replacingOccurrences(of: "+", with: " ").removingPercentEncoding ?? pair[1]
                params[key] = value
            }
        }
        
        return params
        
    }
    
}

extension String: URLConvertible {
    
    public var url: URL? {
        
        if let url = URL(string: self) {
            return url
        }
        
        var charSet = CharacterSet()
        charSet.formUnion(.urlHostAllowed)
        charSet.formUnion(.urlPathAllowed)
        charSet.formUnion(.urlQueryAllowed)
        charSet.formUnion(.urlFragmentAllowed)
        return self.addingPercentEncoding(withAllowedCharacters: charSet).flatMap({ URL(string: $0) })
        
    }
    
    public var urlString: String {
        return self
    }
    
}

extension URL: URLConvertible {
    
    public var url: URL? {
        return self
    }
    
    public var urlString: String {
        return self.absoluteString
    }
    
}
