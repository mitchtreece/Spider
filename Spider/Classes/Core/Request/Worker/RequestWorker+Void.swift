//
//  RequestWorker+Void.swift
//  Spider-Web
//
//  Created by Mitch Treece on 5/22/20.
//

import Foundation

public extension RequestWorker /* Void */ {
    
    /// Starts the worker & serializes a `Void` response.
    /// - Parameter completion: The worker's completion handler.
    func void(_ completion: @escaping (Response<Void>)->()) {
        
        data { res in
            completion(res.map { _ -> Void in
                return ()
            })
        }
        
    }
    
    /// Starts the worker without serializing a value.
    /// - Parameter completion: The worker's completion handler.
    func voidValue(_ completion: @escaping (Error?)->()) {
        
        void { completion(
            $0.error
        )}
        
    }
    
}
