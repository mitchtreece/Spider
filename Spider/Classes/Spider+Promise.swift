//
//  Spider+Promise.swift
//  Pods
//
//  Created by Mitch Treece on 12/13/16.
//
//

import PromiseKit

extension Spider {
    
    public func perform(_ request: SpiderRequest) -> Promise<SpiderResponse> {
        
        let (promise, fulfill, reject) = Promise<SpiderResponse>.pending()
        
        var baseUrl: URL?
        if let baseUrlString = self.baseUrl(from: request), let url = URL(string: baseUrlString) {
            baseUrl = url
        }
        
        let accept = request.header.acceptStringify()
        let session = self.session(withBaseUrl: baseUrl, acceptableContentTypes: accept)
        
        guard let req = self.request(from: request, session: session) else {
            return Promise(error: SpiderError.badRequest)
        }
        
        authorize(request: req, with: request.auth)
        session.dataTask(with: req as URLRequest) { (res, obj, err) in
            let response = SpiderResponse(res, obj, err)
            fulfill(response)
        }.resume()
        
        return promise
        
    }
    
    public func post(path: String, parameters: Any?, auth: Authorization = .none) -> Promise<SpiderResponse> {
        
        let (promise, fulfill, reject) = Promise<SpiderResponse>.pending()
        let request = SpiderRequest(method: .post, baseUrl: nil, path: path, parameters: parameters, auth: auth)
        perform(request) { (res, obj, err) in
            let response = SpiderResponse(res, obj, err)
            fulfill(response)
        }
        return promise
        
    }
    
    public func get(path: String, parameters: Any?, auth: Authorization = .none) -> Promise<SpiderResponse> {
        
        let (promise, fulfill, reject) = Promise<SpiderResponse>.pending()
        let request = SpiderRequest(method: .get, baseUrl: nil, path: path, parameters: parameters, auth: auth)
        perform(request) { (res, obj, err) in
            let response = SpiderResponse(res, obj, err)
            fulfill(response)
        }
        return promise
        
    }
    
    public func delete(path: String, parameters: Any?, auth: Authorization = .none) -> Promise<SpiderResponse> {
        
        let (promise, fulfill, reject) = Promise<SpiderResponse>.pending()
        let request = SpiderRequest(method: .delete, baseUrl: nil, path: path, parameters: parameters, auth: auth)
        perform(request) { (res, obj, err) in
            let response = SpiderResponse(res, obj, err)
            fulfill(response)
        }
        return promise
        
    }
    
}
