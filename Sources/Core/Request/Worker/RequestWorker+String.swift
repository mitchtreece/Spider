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
    
    // MARK: Passthrough
    
    /// Adds a string-response passthrough to the worker.
    /// - parameter block: The passthrough closure.
    /// - returns: This `RequestWorker`.
    func stringResponsePassthrough(encoding: String.Encoding = .utf8,
                                   _ block: @escaping (Response<String>)->()) -> Self {
    
        return dataResponsePassthrough { res in
            block(res.compactMap {
                String(data: $0, encoding: encoding)
            })
        }
        
    }
    
    /// Adds a string passthrough to the worker.
    /// - parameter block: The passthrough closure.
    /// - returns: This `RequestWorker`.
    func stringPassthrough(encoding: String.Encoding = .utf8,
                           _ block: @escaping (String?)->()) -> Self {
        
        return stringResponsePassthrough(encoding: encoding) { res in
            block(res.value)
        }
        
    }
    
}
