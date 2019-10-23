//
//  RequestWorker+Image.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

public extension RequestWorker /* Image */ {
    
    func image(_ completion: @escaping (Response<Image>)->()) {
        
        data { response in
            completion(response.compactMap {
                Image(data: $0)
            })
        }
        
    }
    
    func imageValue(_ completion: @escaping (Image?, Error?)->()) {
        
        image { completion(
            $0.value,
            $0.error
        )}
        
    }
    
}
