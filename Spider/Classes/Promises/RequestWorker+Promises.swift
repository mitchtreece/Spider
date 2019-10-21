//
//  Spider+Promises.swift
//  Pods
//
//  Created by Mitch Treece on 12/13/16.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import UIKit
import PromiseKit

public extension RequestWorker /* Data */ {

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
    
}

public extension RequestWorker /* String */ {
    
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
    
}

public extension RequestWorker /* UIImage */ {
    
    func image() -> Promise<Response<UIImage>> {
        
        return Promise<Response<UIImage>> { seal in
            
            image { response in
                
                switch response.result {
                case .success: seal.fulfill(response)
                case .failure(let error): seal.reject(error)
                }
                
            }
            
        }
        
    }
    
    func imageValue() -> Promise<UIImage> {
        
        return Promise<UIImage> { seal in
            
            image().done { response in
                seal.fulfill(response.value!)
            }.catch { error in
                seal.reject(error)
            }
            
        }
        
    }
    
}

public extension RequestWorker /* Decode */ {
    
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
