//
//  RequestWorker+Promise-UIKit.swift
//  Pods
//
//  Created by Mitch Treece on 12/13/16.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import UIKit
import PromiseKit

public extension RequestWorker /* UIImage */ {
    
    /// Starts the worker & serializes a `UIImage` value.
    /// - returns: A serialized `UIImage` value promise.
    func image() -> Promise<UIImage> {
        
        return Promise<UIImage> { seal in
            
            imageResponse()
                .done { seal.fulfill($0.value!) }
                .catch { seal.reject($0) }
            
        }
        
    }
    
    /// Starts the worker & serializes a `UIImage` response.
    /// - returns: A serialized `UIImage` response promise.
    func imageResponse() -> Promise<Response<UIImage>> {
        
        return Promise<Response<UIImage>> { seal in
            
            imageResponse { response in
                
                switch response.result {
                case .success: seal.fulfill(response)
                case .failure(let error): seal.reject(error)
                }
                
            }
            
        }
        
    }
    
}
