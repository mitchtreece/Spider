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
    
    func voidResponsePublisher() -> AnyPublisher<Response<Void>, Error> {
        
        return Future<Response<Void>, Error> { seal in
            
            self.voidResponse { res in
                
                switch res.result {
                case .success: seal(.success(res))
                case .failure(let err): seal(.failure(err))
                }
                
            }
            
        }
        .eraseToAnyPublisher()
        
    }
    
    
    func voidPublisher() -> AnyPublisher<Void, Error> {

        return self
            .voidResponsePublisher()
            .tryMap { res in
                
                switch res.result {
                case .success: return ()
                case .failure(let err): throw err
                }
                
            }
            .eraseToAnyPublisher()
        
    }
    
}

// MARK: Data

public extension RequestWorker /* Data */ {
    
    func dataResponsePublisher() -> AnyPublisher<Response<Data>, Error> {
        
        return Future<Response<Data>, Error> { seal in
            
            self.dataResponse { res in
                
                switch res.result {
                case .success: seal(.success(res))
                case .failure(let err): seal(.failure(err))
                }
                
            }
            
        }
        .eraseToAnyPublisher()
        
    }
    
    func dataPublisher() -> AnyPublisher<Data, Error> {
        
        return self
            .dataResponsePublisher()
            .tryMap { res in
                
                switch res.result {
                case .success(let val): return val
                case .failure(let err): throw err
                }
                
            }
            .eraseToAnyPublisher()
        
    }
    
}

/// MARK: String

public extension RequestWorker /* String */ {
    
    func stringResponsePublisher(encoding: String.Encoding = .utf8) -> AnyPublisher<Response<String>, Error> {
        
        return Future<Response<String>, Error> { seal in
            
            self.stringResponse(encoding: encoding) { res in
                
                switch res.result {
                case .success: seal(.success(res))
                case .failure(let err): seal(.failure(err))
                }
                
            }
            
        }
        .eraseToAnyPublisher()
        
    }
    
    func stringPublisher(encoding: String.Encoding = .utf8) -> AnyPublisher<String, Error> {
        
        return self
            .stringResponsePublisher()
            .tryMap { res in
                
                switch res.result {
                case .success(let val): return val
                case .failure(let err): throw err
                }
                
            }
            .eraseToAnyPublisher()
        
    }
    
}

/// MARK: JSON

public extension RequestWorker /* JSON */ {
    
    func jsonResponsePublisher() -> AnyPublisher<Response<JSON>, Error> {
        
        return Future<Response<JSON>, Error> { seal in
            
            self.jsonResponse { res in
                
                switch res.result {
                case .success: seal(.success(res))
                case .failure(let err): seal(.failure(err))
                }
                
            }
            
        }
        .eraseToAnyPublisher()
        
    }
    
    func jsonPublisher() -> AnyPublisher<JSON, Error> {
        
        return self
            .jsonResponsePublisher()
            .tryMap { res in
                
                switch res.result {
                case .success(let val): return val
                case .failure(let err): throw err
                }
                
            }
            .eraseToAnyPublisher()
        
    }
    
    func jsonArrayResponsePublisher() -> AnyPublisher<Response<[JSON]>, Error> {
        
        return Future<Response<[JSON]>, Error> { seal in
            
            self.jsonArrayResponse { res in
                
                switch res.result {
                case .success: seal(.success(res))
                case .failure(let err): seal(.failure(err))
                }
                
            }
            
        }
        .eraseToAnyPublisher()
        
    }
    
    func jsonArrayPublisher() -> AnyPublisher<[JSON], Error> {
        
        return self
            .jsonArrayResponsePublisher()
            .tryMap { res in
                
                switch res.result {
                case .success(let val): return val
                case .failure(let err): throw err
                }
                
            }
            .eraseToAnyPublisher()
        
    }
    
}

/// MARK: Image

public extension RequestWorker /* Image */ {
    
    func imageResponsePublisher() -> AnyPublisher<Response<Image>, Error> {
        
        return Future<Response<Image>, Error> { seal in
            
            self.imageResponse { res in
                
                switch res.result {
                case .success: seal(.success(res))
                case .failure(let err): seal(.failure(err))
                }
                
            }
            
        }
        .eraseToAnyPublisher()
        
    }
    
    func imagePublisher() -> AnyPublisher<Image, Error> {
        
        return self
            .imageResponsePublisher()
            .tryMap { res in
                
                switch res.result {
                case .success(let val): return val
                case .failure(let err): throw err
                }
                
            }
            .eraseToAnyPublisher()
        
    }
    
}

/// MARK: Decoded

public extension RequestWorker /* Decoded */ {
    
    func decodedResponsePublisher<T: Decodable>(_ type: T.Type) -> AnyPublisher<Response<T>, Error> {
        
        return Future<Response<T>, Error> { seal in
            
            self.decodedResponse(type) { res in

                switch res.result {
                case .success: seal(.success(res))
                case .failure(let err): seal(.failure(err))
                }

            }
                        
        }
        .eraseToAnyPublisher()
        
    }
    
    func decodedPublisher<T: Decodable>(_ type: T.Type) -> AnyPublisher<T, Error> {
        
        return self
            .decodedResponsePublisher(type)
            .tryMap { res in
                
                switch res.result {
                case .success(let val): return val
                case .failure(let err): throw err
                }
                
            }
            .eraseToAnyPublisher()
        
    }
    
}
