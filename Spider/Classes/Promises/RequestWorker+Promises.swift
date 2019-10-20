//
//  Spider+Promises.swift
//  Pods
//
//  Created by Mitch Treece on 12/13/16.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import PromiseKit

public extension RequestWorker /* Promises */ {

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
    
    func dataValue() -> Promise<Data> {
        
        return Promise<Data> { seal in
            
            data().done { response in
                seal.fulfill(response.value!)
            }.catch { error in
                seal.reject(error)
            }
            
        }
        
    }
    
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
    
    func jsonValue() -> Promise<JSON> {
        
        return Promise<JSON> { seal in
            
            json().done { response in
                seal.fulfill(response.value!)
            }.catch { error in
                seal.reject(error)
            }
            
        }
        
    }
    
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
    
    func jsonArrayValue() -> Promise<[JSON]> {
        
        return Promise<[JSON]> { seal in
            
            jsonArray().done { response in
                seal.fulfill(response.value!)
            }.catch { error in
                seal.reject(error)
            }
            
        }
        
    }
    
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
