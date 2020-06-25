//
//  RequestWorker+JSON.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

public extension RequestWorker /* JSON */ {
    
    /// Starts the worker & serializes a `JSON` response.
    /// - Parameter completion: The worker's completion handler.
    func jsonResponse(_ completion: @escaping (Response<JSON>)->()) {

        dataResponse { response in
            completion(response.map {
                try $0.json()
            })
        }
        
    }
    
    /// Starts the worker & serializes a `JSON` value.
    /// - Parameter completion: The worker's completion handler.
    func json(_ completion: @escaping (JSON?, Error?)->()) {
        
        jsonResponse { completion(
            $0.value,
            $0.error
        )}
        
    }
    
    /// Starts the worker & serializes a `JSON` array response.
    /// - Parameter completion: The worker's completion handler.
    func jsonArrayResponse(_ completion: @escaping (Response<[JSON]>)->()) {
        
        dataResponse { response in
            completion(response.map {
                try $0.jsonArray()
            })
        }
        
    }
    
    /// Starts the worker & serializes a `JSON` array value.
    /// - Parameter completion: The worker's completion handler.
    func jsonArray(_ completion: @escaping ([JSON]?, Error?)->()) {
        
        jsonArrayResponse { completion(
            $0.value,
            $0.error
        )}
        
    }
    
}
