//
//  RequestWorker+String.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

public extension RequestWorker /* String */ {
    
    /// Starts the worker & serializes a `String` response.
    /// - parameter encoding: The string encoding to use; _defaults to utf8_.
    /// - parameter completion: The worker's completion closure.
    func stringResponse(encoding: String.Encoding = .utf8,
                        _ completion: @escaping (Response<String>)->()) {
        
        dataResponse { response in
            completion(response.compactMap {
                String(data: $0, encoding: encoding)
            })
        }
        
    }
    
    /// Starts the worker & serializes a `String` value.
    /// - parameter encoding: The string encoding to use; _defaults to utf8_.
    /// - parameter completion: The worker's completion closure.
    func string(encoding: String.Encoding = .utf8,
                _ completion: @escaping (String?, Error?)->()) {
        
        stringResponse {
            completion(
                $0.value,
                $0.error
            )
        }
        
    }
    
}
