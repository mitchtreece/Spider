//
//  RequestWorker+JSON.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

public extension RequestWorker /* JSON */ {
    
    func jsonResponse(_ completion: @escaping (Response<JSON>)->()) {

        dataResponse { response in
            
            let jsonResponse = response
                .map { try $0.json() }
            
            completion(jsonResponse)
            
        }
        
    }
    
    func json(_ completion: @escaping (JSON?)->()) {
        
        jsonResponse { response in
            completion(response.value)
        }
        
    }
    
    func jsonArrayReponse(_ completion: @escaping (Response<[JSON]>)->()) {
        
        dataResponse { response in
            
            let jsonResponse = response
                .map { try $0.jsonArray() }
            
            completion(jsonResponse)
            
        }
        
    }
    
    func jsonArray(_ completion: @escaping ([JSON]?)->()) {
        
        jsonArrayReponse { response in
            completion(response.value)
        }
        
    }
    
}
