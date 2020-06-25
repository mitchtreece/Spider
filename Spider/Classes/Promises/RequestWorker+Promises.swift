//
//  RequestWorker+Promises.swift
//  Pods
//
//  Created by Mitch Treece on 12/13/16.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import PromiseKit

// MARK: Void

public extension RequestWorker /* Void */ {
    
    /// Starts the worker & serializes a `Void` response.
    /// - Returns: A `Void` response promise.
    func voidResponsePromise() -> Promise<Response<Void>> {
        
        return Promise<Response<Void>> { seal in
            
            voidResponse { res in
                
                switch res.result {
                case .success: seal.fulfill(res)
                case .failure(let error): seal.reject(error)
                }
                
            }
            
        }
        
    }
    
    /// Starts the worker without serializing a value.
    /// - Returns: A `Void` promise.
    func voidPromise() -> Promise<Void> {
        
        return Promise<Void> { seal in
            
            voidResponsePromise().done { res in
                seal.fulfill(())
            }.catch { err in
                seal.reject(err)
            }
            
        }
        
    }
    
}

// MARK: Data

public extension RequestWorker /* Data */ {

    /// Starts the worker & serializes a `Data` response.
    /// - Returns: A `Data` response promise.
    func dataResponsePromise() -> Promise<Response<Data>> {
        
        return Promise<Response<Data>> { seal in
            
            dataResponse { response in
                
                switch response.result {
                case .success: seal.fulfill(response)
                case .failure(let error): seal.reject(error)
                }
                
            }
            
        }
        
    }
    
    /// Starts the worker & serializes a `Data` response.
    /// - Returns: A `Data` promise.
    func dataPromise() -> Promise<Data> {
        
        return Promise<Data> { seal in
            
            dataResponsePromise().done { response in
                seal.fulfill(response.value!)
            }.catch { error in
                seal.reject(error)
            }
            
        }
        
    }
    
}

// MARK: String

public extension RequestWorker /* String */ {
    
    /// Starts the worker & serializes a `String` response.
    /// - Parameter encoding: The string encoding to use; _defaults to utf8_.
    /// - Returns: A `String` response promise.
    func stringResponsePromise(encoding: String.Encoding = .utf8) -> Promise<Response<String>> {
        
        return Promise<Response<String>> { seal in
            
            stringResponse(encoding: encoding) { response in
                
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
    func stringPromise(encoding: String.Encoding = .utf8) -> Promise<String> {
        
        return Promise<String> { seal in
            
            stringResponsePromise(encoding: encoding).done { response in
                seal.fulfill(response.value!)
            }.catch { error in
                seal.reject(error)
            }
            
        }
        
    }
    
}

// MARK: JSON

public extension RequestWorker /* JSON */ {
    
    /// Starts the worker & serializes a `JSON` response.
    /// - Returns: A `JSON` response promise.
    func jsonResponsePromise() -> Promise<Response<JSON>> {
        
        return Promise<Response<JSON>> { seal in
            
            jsonResponse { response in
                
                switch response.result {
                case .success: seal.fulfill(response)
                case .failure(let error): seal.reject(error)
                }
                
            }
            
        }
        
    }
    
    /// Starts the worker & serializes a `JSON` response.
    /// - Returns: A `JSON` promise.
    func jsonPromise() -> Promise<JSON> {
        
        return Promise<JSON> { seal in
            
            jsonResponsePromise().done { response in
                seal.fulfill(response.value!)
            }.catch { error in
                seal.reject(error)
            }
            
        }
        
    }
    
    /// Starts the worker & serializes a `JSON` array response.
    /// - Returns: A `JSON` array response promise.
    func jsonArrayResponsePromise() -> Promise<Response<[JSON]>> {
        
        return Promise<Response<[JSON]>> { seal in
            
            jsonArrayResponse { response in
                
                switch response.result {
                case .success: seal.fulfill(response)
                case .failure(let error): seal.reject(error)
                }
                
            }
            
        }
        
    }
    
    /// Starts the worker & serializes a `JSON` array response.
    /// - Returns: A `JSON` array promise.
    func jsonArrayPromise() -> Promise<[JSON]> {
        
        return Promise<[JSON]> { seal in
            
            jsonArrayResponsePromise().done { response in
                seal.fulfill(response.value!)
            }.catch { error in
                seal.reject(error)
            }
            
        }
        
    }
    
}

// MARK: Image

public extension RequestWorker /* Image */ {
    
    /// Starts the worker & serializes an `Image` response.
    /// - Returns: An `Image` response promise.
    func imageResponsePromise() -> Promise<Response<Image>> {
        
        return Promise<Response<Image>> { seal in
            
            imageResponse { response in
                
                switch response.result {
                case .success: seal.fulfill(response)
                case .failure(let error): seal.reject(error)
                }
                
            }
            
        }
        
    }
    
    /// Starts the worker & serializes an `Image` response.
    /// - Returns: An `Image` promise.
    func imagePromise() -> Promise<Image> {
        
        return Promise<Image> { seal in
            
            imageResponsePromise().done { response in
                seal.fulfill(response.value!)
            }.catch { error in
                seal.reject(error)
            }
            
        }
        
    }
    
}

// MARK: Decode

public extension RequestWorker /* Decode */ {
    
    /// Starts the worker & serializes a `Decodable` object response.
    /// - Returns: A `Decodable` object response promise.
    func decodedResponsePromise<T: Decodable>(_ type: T.Type) -> Promise<Response<T>> {
        
        return Promise<Response<T>> { seal in
            
            decodedResponse(type) { response in
                
                switch response.result {
                case .success: seal.fulfill(response)
                case .failure(let error): seal.reject(error)
                }
                
            }
            
        }
        
    }
    
    /// Starts the worker & serializes a `Decodable` object response.
    /// - Returns: A `Decodable` object promise.
    func decodedPromise<T: Decodable>(_ type: T.Type) -> Promise<T> {
        
        return Promise<T> { seal in
            
            decodedResponsePromise(type).done { response in
                seal.fulfill(response.value!)
            }.catch { error in
                seal.reject(error)
            }
            
        }
        
    }
    
}
