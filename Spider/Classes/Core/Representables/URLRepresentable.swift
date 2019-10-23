//
//  URLRepresentable.swift
//  Pods
//
//  Created by Mitch Treece on 4/19/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

/// `URLRepresentable` is a protocol describing the conversion to various `URL` representations.
public protocol URLRepresentable {
    
    /// A URL representation.
    var url: URL? { get }
    
    /// A URL string representation.
    var urlString: String? { get }
    
    /// The URL's query parameters.
    var urlQueryParameters: [String: String]? { get }
    
}

public extension URLRepresentable {
    
    var urlQueryParameters: [String: String]? {
                
        var params = [String: String]()
        
        self.url?.query?.components(separatedBy: "&").forEach { (component) in
            
            let pair = component.components(separatedBy: "=")
            
            if pair.count == 2 {
                let key = pair[0]
                let value = pair[1].replacingOccurrences(of: "+", with: " ").removingPercentEncoding ?? pair[1]
                params[key] = value
            }
            
        }
        
        return (params.count > 0) ? params : nil
        
    }
    
}

extension URL: URLRepresentable {
    
    public var url: URL? {
        return self
    }
    
    public var urlString: String? {
        return self.absoluteString
    }
    
}

extension String: URLRepresentable {
    
    public var url: URL? {
        
        if let url = URL(string: self) {
            return url
        }
        
        var charSet = CharacterSet()
        charSet.formUnion(.urlHostAllowed)
        charSet.formUnion(.urlPathAllowed)
        charSet.formUnion(.urlQueryAllowed)
        charSet.formUnion(.urlFragmentAllowed)
        
        return self.addingPercentEncoding(withAllowedCharacters: charSet)
            .flatMap { URL(string: $0) }
        
    }
    
    public var urlString: String? {
        return URL(string: self)?.absoluteString
    }
    
}
