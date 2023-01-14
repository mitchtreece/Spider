//
//  RequestWorker+Promise.swift
//  Pods
//
//  Created by Mitch Treece on 12/13/16.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Espresso
import PromiseKit

// MARK: Void

public extension RequestWorker /* Void */ {
    
    /// Starts the worker without serializing a response value.
    /// - returns: A `Void` promise.
    func void() -> Promise<Void> {
        
        return Promise<Void> { seal in
            
            voidResponse()
                .done { _ in seal.fulfill(()) }
                .catch { seal.reject($0) }
            
        }
        
    }
    
    /// Starts the worker & serializes a response without a value.
    /// - returns: A serialized `Void` response promise.
    func voidResponse() -> Promise<Response<Void>> {
        
        return Promise<Response<Void>> { seal in
            
            voidResponse { res in
                
                switch res.result {
                case .success: seal.fulfill(res)
                case .failure(let error): seal.reject(error)
                }
                
            }
            
        }
        
    }
    
}

// MARK: Data

public extension RequestWorker /* Data */ {
    
    /// Starts the worker & serializes a `Data` value.
    /// - returns: A serialized `Data` value promise.
    func data() -> Promise<Data> {
        
        return Promise<Data> { seal in
            
            dataResponse()
                .done { seal.fulfill($0.value!) }
                .catch { seal.reject($0) }
            
        }
        
    }

    /// Starts the worker & serializes a `Data` response.
    /// - returns: A serialized `Data` response promise.
    func dataResponse() -> Promise<Response<Data>> {
        
        return Promise<Response<Data>> { seal in
            
            dataResponse { response in
                
                switch response.result {
                case .success: seal.fulfill(response)
                case .failure(let error): seal.reject(error)
                }
                
            }
            
        }
        
    }
    
}

// MARK: String

public extension RequestWorker /* String */ {
    
    /// Starts the worker & serializes a `String` value.
    /// - parameter encoding: The string encoding to use; _defaults to utf8_.
    /// - returns: A serialized `String` value promise.
    func string(encoding: String.Encoding = .utf8) -> Promise<String> {
        
        return Promise<String> { seal in
            
            stringResponse(encoding: encoding)
                .done { seal.fulfill($0.value!) }
                .catch { seal.reject($0) }
            
        }
        
    }
    
    /// Starts the worker & serializes a `String` response.
    /// - parameter encoding: The string encoding to use; _defaults to utf8_.
    /// - returns: A serialized `String` response promise.
    func stringResponse(encoding: String.Encoding = .utf8) -> Promise<Response<String>> {
        
        return Promise<Response<String>> { seal in
            
            stringResponse(encoding: encoding) { response in
                
                switch response.result {
                case .success: seal.fulfill(response)
                case .failure(let error): seal.reject(error)
                }
                
            }
            
        }
        
    }
    
}

// MARK: JSON

public extension RequestWorker /* JSON */ {
    
    /// Starts the worker & serializes a `JSON` value.
    /// - returns: A serialized `JSON` value promise.
    func json() -> Promise<JSON> {
        
        return Promise<JSON> { seal in
            
            jsonResponse()
                .done { seal.fulfill($0.value!) }
                .catch { seal.reject($0) }
            
        }
        
    }
    
    /// Starts the worker & serializes a `JSON` response.
    /// - returns: A serialized `JSON` response promise.
    func jsonResponse() -> Promise<Response<JSON>> {
        
        return Promise<Response<JSON>> { seal in
            
            jsonResponse { response in
                
                switch response.result {
                case .success: seal.fulfill(response)
                case .failure(let error): seal.reject(error)
                }
                
            }
            
        }
        
    }
    
    /// Starts the worker & serializes a `JSON` array value.
    /// - returns: A serialized `JSON` array value promise.
    func jsonArray() -> Promise<[JSON]> {
        
        return Promise<[JSON]> { seal in
            
            jsonArrayResponse()
                .done { seal.fulfill($0.value!) }
                .catch { seal.reject($0) }
            
        }
        
    }
    
    /// Starts the worker & serializes a `JSON` array response.
    /// - returns: A serialized `JSON` array response promise.
    func jsonArrayResponse() -> Promise<Response<[JSON]>> {
        
        return Promise<Response<[JSON]>> { seal in
            
            jsonArrayResponse { response in
                
                switch response.result {
                case .success: seal.fulfill(response)
                case .failure(let error): seal.reject(error)
                }
                
            }
            
        }
        
    }
    
}

// MARK: Decode

public extension RequestWorker /* Decode */ {
    
    /// Starts the worker & serializes a `Decodable` object response.
    /// - returns: A serialized `Decodable` object value promise.
    func decode<T: Decodable>(_ type: T.Type) -> Promise<T> {
        
        return Promise<T> { seal in
            
            decodeResponse(type)
                .done { seal.fulfill($0.value!) }
                .catch { seal.reject($0) }
            
        }
        
    }
    
    /// Starts the worker & serializes a `Decodable` object response.
    /// - returns: A serialized `Decodable` object response promise.
    func decodeResponse<T: Decodable>(_ type: T.Type) -> Promise<Response<T>> {
        
        return Promise<Response<T>> { seal in
            
            decodeResponse(type) { response in
                
                switch response.result {
                case .success: seal.fulfill(response)
                case .failure(let error): seal.reject(error)
                }
                
            }
            
        }
        
    }
    
}
