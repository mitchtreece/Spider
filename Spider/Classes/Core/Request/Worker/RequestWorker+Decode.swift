//
//  RequestWorker+Decode.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

public extension RequestWorker /* Map */ {

    func decode<T: Decodable>(_ type: T.Type, _ completion: @escaping (Response<T>)->()) {
        
        self.data { dataResponse in
            completion(dataResponse.map { data in
                try JSONDecoder().decode(T.self, from: data)
            })
        }
        
    }
    
}
