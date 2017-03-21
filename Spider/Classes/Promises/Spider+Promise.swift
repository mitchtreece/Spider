//
//  Spider+Promise.swift
//  Pods
//
//  Created by Mitch Treece on 12/13/16.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import PromiseKit

extension Spider {
    
    public func perform(_ request: SpiderRequest) -> Promise<SpiderResponse> {
        
        let (promise, fulfill, reject) = Promise<SpiderResponse>.pending()
        
        perform(request) { (response) in
            fulfill(response)
        }
        
        return promise
        
    }
    
    public func get(path: String, parameters: Any?, auth: Authorization = .none) -> Promise<SpiderResponse> {
        
        let (promise, fulfill, reject) = Promise<SpiderResponse>.pending()
        let request = SpiderRequest(method: .get, baseUrl: nil, path: path, parameters: parameters, auth: auth)

        perform(request).then { (response) -> Void in
            fulfill(response)
        }
        
        return promise
        
    }
    
    public func post(path: String, parameters: Any?, auth: Authorization = .none) -> Promise<SpiderResponse> {
        
        let (promise, fulfill, reject) = Promise<SpiderResponse>.pending()
        let request = SpiderRequest(method: .post, baseUrl: nil, path: path, parameters: parameters, auth: auth)
        
        perform(request).then { (response) -> Void in
            fulfill(response)
        }
        
        return promise
        
    }
    
    public func put(path: String, parameters: Any?, auth: Authorization = .none) -> Promise<SpiderResponse> {
        
        let (promise, fulfill, reject) = Promise<SpiderResponse>.pending()
        let request = SpiderRequest(method: .put, baseUrl: nil, path: path, parameters: parameters, auth: auth)
        
        perform(request).then { (response) -> Void in
            fulfill(response)
        }
        
        return promise
        
    }
    
    public func patch(path: String, parameters: Any?, auth: Authorization = .none) -> Promise<SpiderResponse> {
        
        let (promise, fulfill, reject) = Promise<SpiderResponse>.pending()
        let request = SpiderRequest(method: .patch, baseUrl: nil, path: path, parameters: parameters, auth: auth)
        
        perform(request).then { (response) -> Void in
            fulfill(response)
        }
        
        return promise
        
    }
    
    public func delete(path: String, parameters: Any?, auth: Authorization = .none) -> Promise<SpiderResponse> {
        
        let (promise, fulfill, reject) = Promise<SpiderResponse>.pending()
        let request = SpiderRequest(method: .delete, baseUrl: nil, path: path, parameters: parameters, auth: auth)
        
        perform(request).then { (response) -> Void in
            fulfill(response)
        }
        
        return promise
        
    }
    
}
