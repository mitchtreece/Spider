//
//  RequestWorker+Image.swift
//  Spider-Web
//
//  Created by Mitch Treece on 1/13/23.
//

import UIKit

public extension RequestWorker /* Image */ {
    
    /// Starts the worker & serializes a `UIImage` response.
    /// - parameter completion: The worker's completion closure.
    func imageResponse(_ completion: @escaping (Response<UIImage>)->()) {
        
        dataResponse { response in
            completion(response.compactMap {
                UIImage(data: $0)
            })
        }
        
    }
    
    /// Starts the worker & serializes a `UIImage` value.
    /// - parameter completion: The worker's completion closure.
    func image(_ completion: @escaping (UIImage?, Error?)->()) {
        
        imageResponse {
            completion(
                $0.value,
                $0.error
            )
        }
        
    }
    
}