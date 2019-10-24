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
    
    public let data: Data?
    public let result: Result<T, Error>
    
    public var statusCode: HTTPStatusCode? {
        return HTTPStatusCode.from(response: self.response)
    }
    
    public var size: Data.Size {
        return self.data?.size ?? Data.Size(byteCount: 0)
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
    
    internal init(request: Request,
                  response: URLResponse?,
                  data: Data?,
                  value: T) {
        
        self.request = request
        self.response = response
        self.data = data
        self.result = Result<T, Error>.success(value)
        
    }
    
    internal init(request: Request,
                  response: URLResponse?,
                  data: Data?,
                  error: Error) {
        
        self.request = request
        self.response = response
        self.data = data
        self.result = Result<T, Error>.failure(error)
        
    }
    
    internal func map<S>(_ transform: (T) throws -> S) -> Response<S> {
        
        switch self.result {
        case .success(let value):
            
            do {
                        
                return Response<S>(
                    request: self.request,
                    response: self.response,
                    data: self.data,
                    value: try transform(value)
                )
                
            }
            catch {
                
                return Response<S>(
                    request: self.request,
                    response: self.response,
                    data: self.data,
                    error: error
                )
                
            }
            
        case .failure(let error):
            
            return Response<S>(
                request: self.request,
                response: self.response,
                data: self.data,
                error: error
            )
            
        }
        
    }
    
    internal func compactMap<S>(_ transform: (T) throws -> S?) -> Response<S> {
        
        switch self.result {
        case .success(let value):
            
            do {
                
                let nextValue = try transform(value)
                guard let _nextValue = nextValue else {
                    throw SpiderError.compactMap
                }
                
                return Response<S>(
                    request: self.request,
                    response: self.response,
                    data: self.data,
                    value: _nextValue
                )
                
            }
            catch {
                
                return Response<S>(
                    request: self.request,
                    response: self.response,
                    data: self.data,
                    error: error
                )
                
            }
            
        case .failure(let error):
            
            return Response<S>(
                request: self.request,
                response: self.response,
                data: self.data,
                error: error
            )
            
        }
        
    }
    
}

extension Response: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        
        var string = "Response<\(T.self)> {\n"
        
        // Path
        
        let path = self.response?.url?.absoluteString ?? self.request.path
        string += "\tpath: \(path)\n"
        
        // Status Code
        
        if let statusCode = self.statusCode {
            string += "\tstatus: \(statusCode.rawValue) - \(statusCode.name)\n"
        }
        
        // Result
        
        switch self.result {
        case .success: string += "\tresult: success\n"
        case .failure: string += "\tresult: failure\n"
        }
        
        // Value | Error
        
        if let value = self.value {
            string += "\tvalue: \(value)\n"
        }
        else if let error = self.error {
            string += "\terror: \(error.localizedDescription)\n"
        }
        
        string += "}\n"
        
        return string
        
    }
    
    public var debugDescription: String {
        return self.description
    }
    
}
