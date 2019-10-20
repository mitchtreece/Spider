//
//  Spider+Promises.swift
//  Pods
//
//  Created by Mitch Treece on 12/13/16.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import PromiseKit

public extension RequestWorker /* Promises */ {

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
    
    func data() -> Promise<Data> {
        
        return Promise<Data> { seal in
            
            dataResponse().done { response in
                seal.fulfill(response.value!)
            }.catch { error in
                seal.reject(error)
            }
            
        }
        
    }
    
    func jsonReponse() -> Promise<Response<JSON>> {
        
        return Promise<Response<JSON>> { seal in
            
            jsonResponse { response in
                
                switch response.result {
                case .success: seal.fulfill(response)
                case .failure(let error): seal.reject(error)
                }
                
            }
            
        }
        
    }
    
    func json() -> Promise<JSON> {
        
        return Promise<JSON> { seal in
            
            jsonReponse().done { response in
                seal.fulfill(response.value!)
            }.catch { error in
                seal.reject(error)
            }
            
        }
        
    }
    
    func jsonArrayResponse() -> Promise<Response<[JSON]>> {
        
        return Promise<Response<[JSON]>> { seal in
            
            jsonArrayReponse { response in
                
                switch response.result {
                case .success: seal.fulfill(response)
                case .failure(let error): seal.reject(error)
                }
                
            }
            
        }
        
    }
    
    func jsonArray() -> Promise<[JSON]> {
        
        return Promise<[JSON]> { seal in
            
            jsonArrayResponse().done { response in
                seal.fulfill(response.value!)
            }.catch { error in
                seal.reject(error)
            }
            
        }
        
    }
    
    func decodeReponse<T: Decodable>(_ type: T.Type) -> Promise<Response<T>> {
        
        return Promise<Response<T>> { seal in
            
            decodeResponse(type) { response in
                
                switch response.result {
                case .success: seal.fulfill(response)
                case .failure(let error): seal.reject(error)
                }
                
            }
            
        }
        
    }
    
    func decode<T: Decodable>(_ type: T.Type) -> Promise<T> {
        
        return Promise<T> { seal in
            
            decodeReponse(type).done { response in
                seal.fulfill(response.value!)
            }.catch { error in
                seal.reject(error)
            }
            
        }
        
    }
    
}
