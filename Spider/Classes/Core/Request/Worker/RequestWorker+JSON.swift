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
            completion(response.map {
                try $0.json()
            })
        }
        
    }
    
    func jsonValue(_ completion: @escaping (JSON?, Error?)->()) {
        
        json { completion(
            $0.value,
            $0.error
        )}
        
    }
    
    func jsonArray(_ completion: @escaping (Response<[JSON]>)->()) {
        
        data { response in
            completion(response.map {
                try $0.jsonArray()
            })
        }
        
    }
    
    func jsonArrayValue(_ completion: @escaping ([JSON]?, Error?)->()) {
        
        jsonArray { completion(
            $0.value,
            $0.error
        )}
        
    }
    
}
