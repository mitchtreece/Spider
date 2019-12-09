//
//  Response+Map.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/24/19.
//

import Foundation

public extension Response /* Map */ {
    
    /// Maps a response to another over a different type using a value transform.
    ///
    /// If the value transform throws, this function will return an errored response.
    ///
    /// - Parameter transform: The value transform block.
    /// - Returns: A response over a new type.
    func map<S>(_ transform: (T) throws -> S) -> Response<S> {
        
        switch self.result {
        case .success(let value):
            
            do {
                        
                return Response<S>(
                    request: self.request,
                    response: self.urlResponse,
                    data: self.body?.data,
                    value: try transform(value)
                )
                
            }
            catch {
                return response(with: error)
            }
            
        case .failure(let error): return response(with: error)
        }
        
    }
    
    /// Compact maps a response to another over a different type using a value transform.
    ///
    /// If the value transform throws _or_ produces a `nil` value, this function will
    /// return an errored response.
    ///
    /// - Parameter transform: The value transform block.
    /// - Returns: A response over a new type.
    func compactMap<S>(_ transform: (T) throws -> S?) -> Response<S> {
        
        switch self.result {
        case .success(let value):
            
            do {
                
                let nextValue = try transform(value)
                guard let _nextValue = nextValue else {
                    throw Response.Error.compactMap
                }
                
                return Response<S>(
                    request: self.request,
                    response: self.urlResponse,
                    data: self.body?.data,
                    value: _nextValue
                )
                
            }
            catch {
                return response(with: error)
            }
            
        case .failure(let error): return response(with: error)
        }
        
    }
    
    private func response<S>(with error: Swift.Error) -> Response<S> {
        
        return Response<S>(
            request: self.request,
            response: self.urlResponse,
            data: self.body?.data,
            error: error
        )
        
    }
    
}
