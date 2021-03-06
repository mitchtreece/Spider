//
//  RequestWorker+String.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

public extension RequestWorker /* String */ {
    
    /// Starts the worker & serializes a `String` response.
    /// - Parameter encoding: The string encoding to use; _defaults to utf8_.
    /// - Parameter completion: The worker's completion handler.
    func string(encoding: String.Encoding = .utf8,
                _ completion: @escaping (Response<String>)->()) {
        
        data { response in
            completion(response.compactMap {
                String(data: $0, encoding: encoding)
            })
        }
        
    }
    
    /// Starts the worker & serializes a `String` value.
    /// - Parameter encoding: The string encoding to use; _defaults to utf8_.
    /// - Parameter completion: The worker's completion handler.
    func stringValue(encoding: String.Encoding = .utf8,
                     _ completion: @escaping (String?, Error?)->()) {
        
        string { completion(
            $0.value,
            $0.error
        )}
        
    }
    
}
