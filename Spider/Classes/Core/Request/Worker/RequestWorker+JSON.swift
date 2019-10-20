//
//  RequestWorker+JSON.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

public extension RequestWorker /* JSON */ {
    
    func json(_ completion: @escaping (Response<JSON>)->()) {

        data { response in
            
            let jsonResponse = response
                .map { try $0.json() }
            
            completion(jsonResponse)
            
        }
        
    }
    
    func jsonValue(_ completion: @escaping (JSON?, Error?)->()) {
        
        json { response in
            
            completion(
                response.value,
                response.error
            )
            
        }
        
    }
    
    func jsonArray(_ completion: @escaping (Response<[JSON]>)->()) {
        
        data { response in
            
            let jsonResponse = response
                .map { try $0.jsonArray() }
            
            completion(jsonResponse)
            
        }
        
    }
    
    func jsonArrayValue(_ completion: @escaping ([JSON]?, Error?)->()) {
        
        jsonArray { response in
            
            completion(
                response.value,
                response.error
            )
            
        }
        
    }
    
}
