//
//  Response.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/19/19.
//

import Foundation

public struct Response<T> {
    
    public enum Error: Swift.Error {
        
        case badData
        case serialization
        case compactMap
        case middleware
        case other(description: String)
        
        public var localizedDescription: String {
            
            switch self {
            case .badData: return "Bad data"
            case .serialization: return "Serialization"
            case .compactMap: return "Compact map"
            case .middleware: return "Middleware"
            case .other(let desc): return desc
            }
            
        }
        
    }
    
    public let request: Request
    public let urlResponse: URLResponse?
    public let result: Result<T, Swift.Error>
    public let body: Body?
    
    //public let data: Data?
    
    public var value: T? {
        
        switch self.result {
        case .success(let value): return value
        default: return nil
        }
        
    }
    
    public var error: Swift.Error? {
        
        switch self.result {
        case .failure(let error): return error
        default: return nil
        }
        
    }
    
    public var statusCode: HTTPStatusCode? {
        return HTTPStatusCode.from(response: self.urlResponse)
    }
    
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
