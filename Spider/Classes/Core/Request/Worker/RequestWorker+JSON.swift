//
//  RequestWorker+JSON.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

public extension RequestWorker /* JSON */ {
    
    /// Executes the HTTP request & serializes a `JSON` response.
    /// - Parameter completion: The request's completion handler.
    func json(_ completion: @escaping (Response<JSON>)->()) {

        data { response in
            completion(response.map {
                try $0.json()
            })
        }
        
    }
    
    /// Executes the HTTP request & serializes a `JSON` value.
    /// - Parameter completion: The request's completion handler.
    func jsonValue(_ completion: @escaping (JSON?, Error?)->()) {
        
        json { completion(
            $0.value,
            $0.error
        )}
        
    }
    
    /// Executes the HTTP request & serializes a `JSON` array response.
    /// - Parameter completion: The request's completion handler.
    func jsonArray(_ completion: @escaping (Response<[JSON]>)->()) {
        
        data { response in
            completion(response.map {
                try $0.jsonArray()
            })
        }
        
    }
    
    /// Executes the HTTP request & serializes a `JSON` array value.
    /// - Parameter completion: The request's completion handler.
    func jsonArrayValue(_ completion: @escaping ([JSON]?, Error?)->()) {
        
        jsonArray { completion(
            $0.value,
            $0.error
        )}
        
    }
    
}
