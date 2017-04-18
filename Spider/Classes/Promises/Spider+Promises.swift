//
//  Spider+Promises.swift
//  Pods
//
//  Created by Mitch Treece on 12/13/16.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import PromiseKit

extension Spider {
    
    public func perform(_ request: SpiderRequest) -> Promise<SpiderResponse> {
        
        return Promise<SpiderResponse> { (fulfill, reject) in
            perform(request) { (response) in
                fulfill(response)
            }
        }
        
    }
    
    public func get(_ path: String, parameters: Any? = nil, auth: SpiderAuth? = nil) -> Promise<SpiderResponse> {
        
        let request = SpiderRequest(method: .get, path: path, parameters: parameters, auth: auth)
        return Promise<SpiderResponse> { (fulfill, reject) in
            _ = perform(request).then { (response) -> Void in
                fulfill(response)
            }
        }
        
    }
    
    public func post(_ path: String, parameters: Any? = nil, auth: SpiderAuth? = nil) -> Promise<SpiderResponse> {
        
        let request = SpiderRequest(method: .post, path: path, parameters: parameters, auth: auth)
        return Promise<SpiderResponse> { (fulfill, reject) in
            _ = perform(request).then { (response) -> Void in
                fulfill(response)
            }
        }
        
    }
    
    public func put(_ path: String, parameters: Any? = nil, auth: SpiderAuth? = nil) -> Promise<SpiderResponse> {
        
        let request = SpiderRequest(method: .put, path: path, parameters: parameters, auth: auth)
        return Promise<SpiderResponse> { (fulfill, reject) in
            _ = perform(request).then { (response) -> Void in
                fulfill(response)
            }
        }
        
    }
    
    public func patch(_ path: String, parameters: Any? = nil, auth: SpiderAuth? = nil) -> Promise<SpiderResponse> {
        
        let request = SpiderRequest(method: .patch, path: path, parameters: parameters, auth: auth)
        return Promise<SpiderResponse> { (fulfill, reject) in
            _ = perform(request).then { (response) -> Void in
                fulfill(response)
            }
        }
        
    }
    
    public func delete(_ path: String, parameters: Any? = nil, auth: SpiderAuth? = nil) -> Promise<SpiderResponse> {
        
        let request = SpiderRequest(method: .delete, path: path, parameters: parameters, auth: auth)
        return Promise<SpiderResponse> { (fulfill, reject) in
            _ = perform(request).then { (response) -> Void in
                fulfill(response)
            }
        }
        
    }
    
}
