//
//  RequestWorker+Decode.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

public extension RequestWorker /* Decode */ {

    func decodeResponse<T: Decodable>(_ type: T.Type, _ completion: @escaping (Response<T>)->()) {
        
        dataResponse { response in
            
            completion(response.map { data in
                try JSONDecoder().decode(T.self, from: data)
            })
            
        }
        
    }
    
    func decode<T: Decodable>(_ type: T.Type, _ completion: @escaping (T?)->()) {
        
        decodeResponse(type) { response in
            completion(response.value)
        }
        
    }
    
}
