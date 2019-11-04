//
//  RequestWorker+Image.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

public extension RequestWorker /* Image */ {
    
    /// Executes the HTTP request & serializes an `Image` response.
    /// - Parameter completion: The request's completion handler.
    func image(_ completion: @escaping (Response<Image>)->()) {
        
        data { response in
            completion(response.compactMap {
                Image(data: $0)
            })
        }
        
    }
    
    /// Executes the HTTP request & serializes an `Image` value.
    /// - Parameter completion: The request's completion handler.
    func imageValue(_ completion: @escaping (Image?, Error?)->()) {
        
        image { completion(
            $0.value,
            $0.error
        )}
        
    }
    
}
