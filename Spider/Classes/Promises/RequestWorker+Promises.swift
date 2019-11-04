//
//  Spider+Promises.swift
//  Pods
//
//  Created by Mitch Treece on 12/13/16.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import PromiseKit

public extension RequestWorker /* Data */ {

    /// Starts the worker & serializes a `Data` response.
    /// - Returns: A `Data` response promise.
    func data() -> Promise<Response<Data>> {
        
        return Promise<Response<Data>> { seal in
            
            data { response in
                
                switch response.result {
                case .success: seal.fulfill(response)
                case .failure(let error): seal.reject(error)
                }
                
            }
            
        }
        
    }
    
    /// Starts the worker & serializes a `Data` response.
    /// - Returns: A `Data` promise.
    func dataValue() -> Promise<Data> {
        
        return Promise<Data> { seal in
            
            data().done { response in
                seal.fulfill(response.value!)
            }.catch { error in
                seal.reject(error)
            }
            
        }
        
    }
    
}

public extension RequestWorker /* String */ {
    
    /// Starts the worker & serializes a `String` response.
    /// - Parameter encoding: The string encoding to use; _defaults to utf8_.
    /// - Returns: A `String` response promise.
    func string(encoding: String.Encoding = .utf8) -> Promise<Response<String>> {
        
        return Promise<Response<String>> { seal in
            
            string(encoding: encoding) { response in
                
                switch response.result {
                case .success: seal.fulfill(response)
                case .failure(let error): seal.reject(error)
                }
                
            }
            
        }
        
    }
    
    /// Starts the worker & serializes a `String` response.
    /// - Parameter encoding: The string encoding to use; _defaults to utf8_.
    /// - Returns: A `String` promise.
    func stringValue(encoding: String.Encoding = .utf8) -> Promise<String> {
        
        return Promise<String> { seal in
            
            string(encoding: encoding).done { response in
                seal.fulfill(response.value!)
            }.catch { error in
                seal.reject(error)
            }
            
        }
        
    }
    
}

public extension RequestWorker /* JSON */ {
    
    /// Starts the worker & serializes a `JSON` response.
    /// - Returns: A `JSON` response promise.
    func json() -> Promise<Response<JSON>> {
        
        return Promise<Response<JSON>> { seal in
            
            json { response in
                
                switch response.result {
                case .success: seal.fulfill(response)
                case .failure(let error): seal.reject(error)
                }
                
            }
            
        }
        
    }
    
    /// Starts the worker & serializes a `JSON` response.
    /// - Returns: A `JSON` promise.
    func jsonValue() -> Promise<JSON> {
        
        return Promise<JSON> { seal in
            
            json().done { response in
                seal.fulfill(response.value!)
            }.catch { error in
                seal.reject(error)
            }
            
        }
        
    }
    
    /// Starts the worker & serializes a `JSON` array response.
    /// - Returns: A `JSON` array response promise.
    func jsonArray() -> Promise<Response<[JSON]>> {
        
        return Promise<Response<[JSON]>> { seal in
            
            jsonArray { response in
                
                switch response.result {
                case .success: seal.fulfill(response)
                case .failure(let error): seal.reject(error)
                }
                
            }
            
        }
        
    }
    
    /// Starts the worker & serializes a `JSON` array response.
    /// - Returns: A `JSON` array promise.
    func jsonArrayValue() -> Promise<[JSON]> {
        
        return Promise<[JSON]> { seal in
            
            jsonArray().done { response in
                seal.fulfill(response.value!)
            }.catch { error in
                seal.reject(error)
            }
            
        }
        
    }
    
}

public extension RequestWorker /* UIImage */ {
    
    /// Starts the worker & serializes an `Image` response.
    /// - Returns: An `Image` response promise.
    func image() -> Promise<Response<Image>> {
        
        return Promise<Response<Image>> { seal in
            
            image { response in
                
                switch response.result {
                case .success: seal.fulfill(response)
                case .failure(let error): seal.reject(error)
                }
                
            }
            
        }
        
    }
    
    /// Starts the worker & serializes an `Image` response.
    /// - Returns: An `Image` promise.
    func imageValue() -> Promise<Image> {
        
        return Promise<Image> { seal in
            
            image().done { response in
                seal.fulfill(response.value!)
            }.catch { error in
                seal.reject(error)
            }
            
        }
        
    }
    
}

public extension RequestWorker /* Decode */ {
    
    /// Starts the worker & serializes a `Decodable` object response.
    /// - Returns: A `Decodable` object response promise.
    func decode<T: Decodable>(_ type: T.Type) -> Promise<Response<T>> {
        
        return Promise<Response<T>> { seal in
            
            decode(type) { response in
                
                switch response.result {
                case .success: seal.fulfill(response)
                case .failure(let error): seal.reject(error)
                }
                
            }
            
        }
        
    }
    
    /// Starts the worker & serializes a `Decodable` object response.
    /// - Returns: A `Decodable` object promise.
    func decodeValue<T: Decodable>(_ type: T.Type) -> Promise<T> {
        
        return Promise<T> { seal in
            
            decode(type).done { response in
                seal.fulfill(response.value!)
            }.catch { error in
                seal.reject(error)
            }
            
        }
        
    }
    
}
