//
//  RequestWorker+Combine.swift
//  Pods
//
//  Created by Mitch Treece on 12/13/16.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Combine

// MARK: Void

public extension RequestWorker /* Void */ {
    
    func voidResponseFuture() -> Future<Response<Void>, Error> {
        
        return Future<Response<Void>, Error> { seal in
            
            self.voidResponse { res in
                
                switch res.result {
                case .success: seal(.success(res))
                case .failure(let err): seal(.failure(err))
                }
                
            }
            
        }
        
    }
    
    
    func voidFuture() -> Future<Void, Error> {
        
        return Future<Void, Error> { seal in
            
            self.voidResponseFuture().resultSink { result in
                
                switch result {
                case .success: seal(.success(()))
                case .failure(let err): seal(.failure(err))
                }
                
            }
            
        }
        
    }
    
}

// MARK: Data

public extension RequestWorker /* Data */ {
    
    func dataResponseFuture() -> Future<Response<Data>, Error> {
        
        return Future<Response<Data>, Error> { seal in
            
            self.dataResponse { res in
                
                switch res.result {
                case .success: seal(.success(res))
                case .failure(let err): seal(.failure(err))
                }
                
            }
            
        }
        
    }
    
    
    func dataFuture() -> Future<Data, Error> {
        
        return Future<Data, Error> { seal in
            
            self.dataResponseFuture().resultSink { result in
                
                switch result {
                case .success(let res): seal(.success(res.value!))
                case .failure(let err): seal(.failure(err))
                }
                
            }
            
        }
        
    }
    
}

/// MARK: String

public extension RequestWorker /* String */ {
    
    func stringResponseFuture(encoding: String.Encoding = .utf8) -> Future<Response<String>, Error> {
        
        return Future<Response<String>, Error> { seal in
            
            self.stringResponse(encoding: encoding) { res in
                
                switch res.result {
                case .success: seal(.success(res))
                case .failure(let err): seal(.failure(err))
                }
                
            }
            
        }
        
    }
    
    func stringFuture(encoding: String.Encoding = .utf8) -> Future<String, Error> {
        
        return stringResponseFuture(encoding: encoding)
            .flatMap { res in
                
                Future<String, Error> { seal in
                    
                    switch res.result {
                    case .success(let val): seal(.success(val))
                    case .failure(let err): seal(.failure(err))
                    }
                    
                }
                
            })
        
//        return Future<String, Error> { seal in
//
//            self.stringResponseFuture(encoding: encoding).resultSink { result in
//
//                switch result {
//                case .success(let res): seal(.success(res.value!))
//                case .failure(let err): seal(.failure(err))
//                }
//
//            }
//
//        }
        
    }
    
}

//// MARK: JSON
//
//public extension RequestWorker /* JSON */ {
//
//    /// Starts the worker & serializes a `JSON` response.
//    /// - Returns: A `JSON` response promise.
//    func json() -> Promise<Response<JSON>> {
//
//        return Promise<Response<JSON>> { seal in
//
//            json { response in
//
//                switch response.result {
//                case .success: seal.fulfill(response)
//                case .failure(let error): seal.reject(error)
//                }
//
//            }
//
//        }
//
//    }
//
//    /// Starts the worker & serializes a `JSON` response.
//    /// - Returns: A `JSON` promise.
//    func jsonValue() -> Promise<JSON> {
//
//        return Promise<JSON> { seal in
//
//            json().done { response in
//                seal.fulfill(response.value!)
//            }.catch { error in
//                seal.reject(error)
//            }
//
//        }
//
//    }
//
//    /// Starts the worker & serializes a `JSON` array response.
//    /// - Returns: A `JSON` array response promise.
//    func jsonArray() -> Promise<Response<[JSON]>> {
//
//        return Promise<Response<[JSON]>> { seal in
//
//            jsonArray { response in
//
//                switch response.result {
//                case .success: seal.fulfill(response)
//                case .failure(let error): seal.reject(error)
//                }
//
//            }
//
//        }
//
//    }
//
//    /// Starts the worker & serializes a `JSON` array response.
//    /// - Returns: A `JSON` array promise.
//    func jsonArrayValue() -> Promise<[JSON]> {
//
//        return Promise<[JSON]> { seal in
//
//            jsonArray().done { response in
//                seal.fulfill(response.value!)
//            }.catch { error in
//                seal.reject(error)
//            }
//
//        }
//
//    }
//
//}
//
//// MARK: Image
//
//public extension RequestWorker /* Image */ {
//
//    /// Starts the worker & serializes an `Image` response.
//    /// - Returns: An `Image` response promise.
//    func image() -> Promise<Response<Image>> {
//
//        return Promise<Response<Image>> { seal in
//
//            image { response in
//
//                switch response.result {
//                case .success: seal.fulfill(response)
//                case .failure(let error): seal.reject(error)
//                }
//
//            }
//
//        }
//
//    }
//
//    /// Starts the worker & serializes an `Image` response.
//    /// - Returns: An `Image` promise.
//    func imageValue() -> Promise<Image> {
//
//        return Promise<Image> { seal in
//
//            image().done { response in
//                seal.fulfill(response.value!)
//            }.catch { error in
//                seal.reject(error)
//            }
//
//        }
//
//    }
//
//}
//
//// MARK: Decode
//
//public extension RequestWorker /* Decode */ {
//
//    /// Starts the worker & serializes a `Decodable` object response.
//    /// - Returns: A `Decodable` object response promise.
//    func decode<T: Decodable>(_ type: T.Type) -> Promise<Response<T>> {
//
//        return Promise<Response<T>> { seal in
//
//            decode(type) { response in
//
//                switch response.result {
//                case .success: seal.fulfill(response)
//                case .failure(let error): seal.reject(error)
//                }
//
//            }
//
//        }
//
//    }
//
//    /// Starts the worker & serializes a `Decodable` object response.
//    /// - Returns: A `Decodable` object promise.
//    func decodeValue<T: Decodable>(_ type: T.Type) -> Promise<T> {
//
//        return Promise<T> { seal in
//
//            decode(type).done { response in
//                seal.fulfill(response.value!)
//            }.catch { error in
//                seal.reject(error)
//            }
//
//        }
//
//    }
//
//}
