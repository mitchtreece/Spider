//
//  RequestWorker+Void.swift
//  Spider-Web
//
//  Created by Mitch Treece on 5/22/20.
//

import Foundation

public extension RequestWorker /* Void */ {
    
    /// Starts the worker & serializes a response without a value.
    /// - parameter completion: The worker's completion closure.
    func voidResponse(_ completion: @escaping (Response<Void>)->()) {
        
        dataResponse { response in
            completion(response.map { _ -> Void in
                return ()
            })
        }
        
    }
    
    /// Starts the worker without serializing a value.
    /// - parameter completion: The worker's completion closure.
    func void(_ completion: @escaping (Error?)->()) {
        
        voidResponse {
            completion($0.error)
        }
        
    }
    
    // MARK: Passthrough
    
    /// Adds a void-response passthrough to the worker.
    /// - parameter block: The passthrough closure.
    /// - returns: This `RequestWorker`.
    func voidResponsePassthrough(_ block: @escaping (Response<Void>)->()) -> Self {
        
        return dataResponsePassthrough { res in
            block(res.compactMap { _ in () })
        }
        
    }
    
    /// Adds a void passthrough to the worker.
    /// - parameter block: The passthrough closure.
    /// - returns: This `RequestWorker`.
    func voidPassthrough(_ block: @escaping ()->()) -> Self {
        
        return voidResponsePassthrough { _ in
            block()
        }
        
    }
    
}
