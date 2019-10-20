//
//  RequestWorker+JSON.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

public extension RequestWorker /* JSON */ {
    
    func json(_ completion: @escaping (Response<JSON>)->()) {

        self.data { dataResponse in
            
            let jsonResponse = dataResponse
                .map { try $0.json() }
            
            completion(jsonResponse)
            
        }
        
    }
    
    func jsonArray(_ completion: @escaping (Response<[JSON]>)->()) {
        
        self.data { dataResponse in
            
            let jsonResponse = dataResponse
                .map { try $0.jsonArray() }
            
            completion(jsonResponse)
            
        }
        
    }
    
}
