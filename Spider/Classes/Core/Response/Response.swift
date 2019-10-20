//
//  Response.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/19/19.
//

import Foundation

public struct Response<T> {
    
    public let request: Request
    public let response: URLResponse?
    public let result: Result<T, Error>
    
    public var statusCode: HTTPStatusCode? {
        return HTTPStatusCode.from(response: self.response)
    }
    
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
    
    internal init(request: Request, response: URLResponse?, value: T) {
        
        self.request = request
        self.response = response
        self.result = Result<T, Error>.success(value)
        
    }
    
    internal init(request: Request, response: URLResponse?, error: Error) {
        
        self.request = request
        self.response = response
        self.result = Result<T, Error>.failure(error)
        
    }
    
    internal func map<S>(_ transform: (T) throws -> S) -> Response<S> {
        
        switch self.result {
        case .success(let value):
            
            do {
                        
                return Response<S>(
                    request: self.request,
                    response: self.response,
                    value: try transform(value)
                )
                
            }
            catch(let error) {
                
                return Response<S>(
                    request: self.request,
                    response: self.response,
                    error: error
                )
                
            }
            
        case .failure(let error):
            
            return Response<S>(
                request: self.request,
                response: self.response,
                error: error
            )
            
        }
        
    }
    
}
