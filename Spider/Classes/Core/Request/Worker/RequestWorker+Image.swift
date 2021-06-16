//
//  RequestWorker+Image.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

public extension RequestWorker /* Image */ {
    
    /// Starts the worker & serializes an `Image` response.
    /// - parameter completion: The worker's completion closure.
    func imageResponse(_ completion: @escaping (Response<Image>)->()) {
        
        dataResponse { response in
            completion(response.compactMap {
                Image(data: $0)
            })
        }
        
    }
    
    /// Starts the worker & serializes an `Image` value.
    /// - parameter completion: The worker's completion closure.
    func image(_ completion: @escaping (Image?, Error?)->()) {
        
        imageResponse {
            completion(
                $0.value,
                $0.error
            )
        }
        
    }
    
}
