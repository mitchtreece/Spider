//
//  Response.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/19/19.
//

import Foundation

public struct Response<T> {
    
    public let result: Result<T, Error>
    
    public var value: T? {
        
        switch self.result {
        case .success(let value): return value
        default: return nil
        }
        
    }
    
    public var error: Error? {
        
        switch self.result {
        case .failure(let error): return error
        default: return nil
        }
        
    }
    
    internal init(value: T) {
        self.result = Result<T, Error>.success(value)
    }
    
    internal init(error: Error) {
        self.result = Result<T, Error>.failure(error)
    }
    
    internal func map<S>(_ transform: (T) throws -> S) -> Response<S> {
        
        switch self.result {
        case .success(let value):
            
            do {
                let next = try transform(value)
                return Response<S>(value: next)
            }
            catch(let error) {
                return Response<S>(error: error)
            }
            
        case .failure(let error): return Response<S>(error: error)
        }
        
    }
    
}
