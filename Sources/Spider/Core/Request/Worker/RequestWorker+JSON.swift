//
//  RequestWorker+JSON.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Espresso

public extension RequestWorker /* JSON */ {
    
    /// Starts the worker & serializes a `JSON` response.
    /// - parameter completion: The worker's completion closure.
    func jsonResponse(_ completion: @escaping (Response<JSON>)->()) {

        dataResponse { response in
            completion(response.map {
                try $0.asJsonThrowing()
            })
        }
        
    }
    
    /// Starts the worker & serializes a `JSON` value.
    /// - parameter completion: The worker's completion closure.
    func json(_ completion: @escaping (JSON?, Error?)->()) {
        
        jsonResponse {
            completion(
                $0.value,
                $0.error
            )
        }
        
    }
    
    /// Starts the worker & serializes a `JSON` array response.
    /// - parameter completion: The worker's completion closure.
    func jsonArrayResponse(_ completion: @escaping (Response<[JSON]>)->()) {
        
        dataResponse { response in
            completion(response.map {
                try $0.asJsonArrayThrowing()
            })
        }
        
    }
    
    /// Starts the worker & serializes a `JSON` array value.
    /// - parameter completion: The worker's completion closure.
    func jsonArray(_ completion: @escaping ([JSON]?, Error?)->()) {
        
        jsonArrayResponse {
            completion(
                $0.value,
                $0.error
            )
        }
        
    }
    
}