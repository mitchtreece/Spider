//
//  RequestWorker+Promise-UIKit.swift
//  Pods
//
//  Created by Mitch Treece on 12/13/16.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import SpiderUI
import Kingfisher
import PromiseKit

public extension RequestWorker /* Image */ {
    
    /// Starts the worker & serializes an image value.
    /// - returns: A serialized image value promise.
    func image() -> Promise<KFCrossPlatformImage> {
        
        return Promise<KFCrossPlatformImage> { seal in
            
            imageResponse()
                .done { seal.fulfill($0.value!) }
                .catch { seal.reject($0) }
            
        }
        
    }
    
    /// Starts the worker & serializes an image response.
    /// - returns: A serialized image response promise.
    func imageResponse() -> Promise<Response<KFCrossPlatformImage>> {
        
        return Promise<Response<KFCrossPlatformImage>> { seal in
            
            imageResponse { response in
                
                switch response.result {
                case .success: seal.fulfill(response)
                case .failure(let error): seal.reject(error)
                }
                
            }
            
        }
        
    }
    
}
