//
//  Response.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/19/19.
//

import Foundation
import typealias Espresso.JSON

/// An HTTP response.
public struct Response<T> {
    
    /// Representation of the various HTTP response errors.
    public enum Error: Swift.Error {
        
        /// A bad data error.
        case badData
        
        /// A data serialization error.
        case serialization
        
        /// A compact map error.
        case compactMap
        
        /// A middleware error.
        case middleware
        
        /// A custom response error.
        case custom(description: String)
        
        public var localizedDescription: String {
            
            switch self {
            case .badData: return "Bad data"
            case .serialization: return "Serialization"
            case .compactMap: return "Compact map"
            case .middleware: return "Middleware"
            case .custom(let desc): return desc
            }
            
        }
        
    }
    
    /// The response's associated request.
    public let request: Request
    
    /// The response's underlying `URLResponse`.
    public let urlResponse: URLResponse?
    
    /// The response's result.
    public let result: Result<T, Swift.Error>
    
    // The response's data body.
    public let body: Body?
    
    /// The response's value.
    public var value: T? {
        
        switch self.result {
        case .success(let value): return value
        default: return nil
        }
        
    }
    
    /// The response's error.
    public var error: Swift.Error? {
        
        switch self.result {
        case .failure(let error): return error
        default: return nil
        }
        
    }
    
    /// The response's HTTP status code.
    public var statusCode: HTTPStatusCode? {
        return HTTPStatusCode.from(response: self.urlResponse)
    }
    
    /// The response's body size.
    public var size: Data.Size {
        return self.body?.size ?? Data.Size(byteCount: 0)
    }
        
    internal init(request: Request,
                  response: URLResponse?,
                  data: Data?,
                  value: T) {
        
        self.request = request
        self.urlResponse = response
        self.body = Body(data: data)
        self.result = Result<T, Swift.Error>.success(value)
        
    }
    
    internal init(request: Request,
                  response: URLResponse?,
                  data: Data?,
                  error: Swift.Error) {
        
        self.request = request
        self.urlResponse = response
        self.body = Body(data: data)
        self.result = Result<T, Swift.Error>.failure(error)
        
    }
    
}

extension Response: CustomStringConvertible, CustomReflectable {
    
    public var description: String {
        
        var string = "Response<\(T.self)> {\n"
        
        // Path
        
        let path = self.urlResponse?.url?.absoluteString ?? self.request.path
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
            string += "\tvalue: \(description(for: value))\n"
        }
        else if let error = self.error {
            string += "\terror: \(description(for: error))\n"
        }
        
        string += "}"
        return string
        
    }
    
    public var customMirror: Mirror {
        return Mirror(self, children: [])
    }
    
    private func description(for value: T) -> String {
        
        if let array = value as? [Any] {
            
            if let _ = array as? [JSON] {
                return "Array<JSON> - \(array.count) element(s)"
            }
            
            return "\(type(of: value)) - \(array.count) element(s)"
            
        }
        else if let json = value as? JSON {
            return "JSON - \(json.keys.count) key/value pair(s)"
        }
        else if let string = value as? String {
            return "\"\(string)\""
        }
        else if let bool = value as? Bool {
            return bool ? "true" : "false"
        }
        
        return String(describing: value)
        
    }
    
    private func description(for error: Swift.Error) -> String {
        
        if let decodingError = error as? DecodingError {
            
            switch decodingError {
            case .dataCorrupted: return "decoding data corrupted"
            case .keyNotFound(let key, _): return "decoding key not found \"\(key.stringValue)\""
            case .valueNotFound(let value, _): return "decoding value not found \"\(value)\""
            case .typeMismatch(let type, _): return "decoding type mismatch: \"\(type)\""
            @unknown default: return "decoding error"
            }
            
        }
        
        return error.localizedDescription
        
    }
    
}
