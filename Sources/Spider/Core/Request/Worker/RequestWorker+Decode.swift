//
//  RequestWorker+Decode.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

public extension RequestWorker /* Decode */ {

    /// Starts the worker & serializes a `Decodable` object response.
    /// - parameter type: The `Decodable` object type.
    /// - parameter completion: The worker's completion closure.
    func decodeResponse<T: Decodable>(_ type: T.Type, _ completion: @escaping (Response<T>)->()) {
        
        dataResponse { response in
            completion(response.map {
                try JSONDecoder().decode(T.self, from: $0)
            })
        }
        
    }
    
    /// Starts the worker & serializes a `Decodable` object value.
    /// - parameter type: The `Decodable` object type.
    /// - parameter completion: The worker's completion closure.
    func decode<T: Decodable>(_ type: T.Type, _ completion: @escaping (T?, Error?)->()) {
        
        decodeResponse(type) {
            completion(
                $0.value,
                $0.error
            )
        }
        
    }
    
    // MARK: Passthrough
    
    /// Adds a decode-response passthrough to the worker.
    /// - parameter block: The passthrough closure.
    /// - returns: This `RequestWorker`.
    func decodeResponsePassthrough<T: Decodable>(_ type: T.Type,
                                                 _ block: @escaping (Response<T>)->()) -> Self {
        
        return dataResponsePassthrough { res in
            block(res.map {
                try JSONDecoder().decode(T.self, from: $0)
            })
        }
        
    }
    
    /// Adds a decode passthrough to the worker.
    /// - parameter block: The passthrough closure.
    /// - returns: This `RequestWorker`.
    func decodeResponsePassthrough<T: Decodable>(_ type: T.Type,
                                                _ block: @escaping (T?)->()) -> Self {
        
        return decodeResponsePassthrough(type) { res in
            block(res.value)
        }
        
    }
    
}
