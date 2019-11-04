//
//  RequestWorker+Decode.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

public extension RequestWorker /* Decode */ {

    /// Executes the HTTP request & serializes a `Decodable` object response.
    /// - Parameter type: The `Decodable` type to serialize.
    /// - Parameter completion: The request's completion handler.
    func decode<T: Decodable>(_ type: T.Type, _ completion: @escaping (Response<T>)->()) {
        
        data { response in
            completion(response.map {
                try JSONDecoder().decode(T.self, from: $0)
            })
        }
        
    }
    
    /// Executes the HTTP request & serializes a `Decodable` object value.
    /// - Parameter type: The `Decodable` type to serialize.
    /// - Parameter completion: The request's completion handler.
    func decodeValue<T: Decodable>(_ type: T.Type, _ completion: @escaping (T?, Error?)->()) {
        
        decode(type) { completion(
            $0.value,
            $0.error
        )}
        
    }
    
}
