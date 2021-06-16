//
//  RequestWorker+Async.swift
//  Spider-Web
//
//  Created by Mitch Treece on 6/15/21.
//

import Foundation

// MARK: Void

@available(iOS 15, *)
@available(macOS 12, *)
public extension RequestWorker /* Void */ {
    
    /// Starts the worker & serializes a response without a value.
    /// - returns: A serialized `Void` response.
    func voidResponse() async throws -> Response<Void> {
        
        try await withCheckedThrowingContinuation { c in
            
            void { res in
                
                switch res.result {
                case .success: c.resume(returning: res)
                case .failure(let err): c.resume(throwing: err)
                }
                
            }
            
        }
        
    }
    
    /// Starts the worker without serializing a response value.
    func void() async throws {
        
        try await withCheckedThrowingContinuation { (c: CheckedContinuation<Void, Error>) in
            void {
                c.resume(with: $0.result)
            }
        }
        
    }
    
}

// MARK: Data

@available(iOS 15, *)
@available(macOS 12, *)
public extension RequestWorker /* Data */ {
    
    /// Starts the worker & serializes a `Data` response.
    /// - returns: A serialized `Data` response.
    func dataResponse() async throws -> Response<Data> {
        
        try await withCheckedThrowingContinuation { c in
            
            data { res in
                
                switch res.result {
                case .success: c.resume(returning: res)
                case .failure(let err): c.resume(throwing: err)
                }
                
            }
            
        }
        
    }
    
    /// Starts the worker & serializes a `Data` value.
    /// - returns: A serialized `Data` value.
    func data() async throws -> Data {
        
        try await withCheckedThrowingContinuation { c in
            data {
                c.resume(with: $0.result)
            }
        }
        
    }
    
}

// MARK: String

@available(iOS 15, *)
@available(macOS 12, *)
public extension RequestWorker /* String */ {
    
    /// Starts the worker & serializes a `String` response.
    /// - parameter encoding: The string encoding to use; _defaults to utf8_.
    /// - returns: A serialized `String` response.
    func stringResponse(encoding: String.Encoding = .utf8) async throws -> Response<String> {
        
        try await withCheckedThrowingContinuation { c in
            
            string(encoding: encoding) { res in
                
                switch res.result {
                case .success: c.resume(returning: res)
                case .failure(let err): c.resume(throwing: err)
                }
                
            }
            
        }
        
    }
    
    /// Starts the worker & serializes a `String` value.
    /// - parameter encoding: The string encoding to use; _defaults to utf8_.
    /// - returns: A serialized `String` value.
    func string(encoding: String.Encoding = .utf8) async throws -> String {
        
        try await withCheckedThrowingContinuation { c in
            string(encoding: encoding) {
                c.resume(with: $0.result)
            }
        }
        
    }
    
}

// MARK: JSON

@available(iOS 15, *)
@available(macOS 12, *)
public extension RequestWorker /* JSON */ {
    
    /// Starts the worker & serializes a `JSON` response.
    /// - returns: A serialized `JSON` response.
    func jsonResponse() async throws -> Response<JSON> {
        
        try await withCheckedThrowingContinuation { c in
            
            json { res in
                
                switch res.result {
                case .success: c.resume(returning: res)
                case .failure(let err): c.resume(throwing: err)
                }
                
            }
            
        }
        
    }
    
    /// Starts the worker & serializes a `JSON` value.
    /// - returns: A serialized `JSON` value.
    func json() async throws -> JSON {
    
        try await withCheckedThrowingContinuation { c in
            json {
                c.resume(with: $0.result)
            }
        }
        
    }
    
    /// Starts the worker & serializes a `[JSON]` response.
    /// - returns: A serialized `[JSON]` response.
    func jsonArrayResponse() async throws -> Response<[JSON]> {
        
        try await withCheckedThrowingContinuation { c in
            
            jsonArray { res in
                
                switch res.result {
                case .success: c.resume(returning: res)
                case .failure(let err): c.resume(throwing: err)
                }
                
            }
            
        }
        
    }
    
    /// Starts the worker & serializes a `[JSON]` value.
    /// - returns: A serialized `[JSON]` value.
    func jsonArray() async throws -> [JSON] {
        
        try await withCheckedThrowingContinuation { c in
            jsonArray {
                c.resume(with: $0.result)
            }
        }
        
    }
    
}

// MARK: Image

@available(iOS 15, *)
@available(macOS 12, *)
public extension RequestWorker /* Image */ {
    
    /// Starts the worker & serializes a `Image` response.
    /// - returns: A serialized `Image` response.
    func imageResponse() async throws -> Response<Image> {
        
        try await withCheckedThrowingContinuation { c in
            
            image { res in
                
                switch res.result {
                case .success: c.resume(returning: res)
                case .failure(let err): c.resume(throwing: err)
                }
                
            }
            
        }
        
    }
    
    /// Starts the worker & serializes an `Image` value.
    /// - returns: A serialized `Image` value.
    func image() async throws -> Image {
        
        try await withCheckedThrowingContinuation { c in
            image {
                c.resume(with: $0.result)
            }
        }
        
    }
    
}

// MARK: Decode

@available(iOS 15, *)
@available(macOS 12, *)
public extension RequestWorker /* Image */ {
    
    /// Starts the worker & serializes a `Decodable` object response.
    /// - returns: A serialized `Decodable` object response.
    func decodeResponse<T: Decodable>(_ type: T.Type) async throws -> Response<T> {
        
        try await withCheckedThrowingContinuation { c in
            
            decode(type) { res in
                
                switch res.result {
                case .success: c.resume(returning: res)
                case .failure(let err): c.resume(throwing: err)
                }
                
            }
            
        }
        
    }
    
    /// Starts the worker & serializes a `Decodable` object value.
    /// - returns: A serialized `Decodable` object value.
    func decode<T: Decodable>(_ type: T.Type) async throws -> T {
        
        try await withCheckedThrowingContinuation { c in
            decode(type) {
                c.resume(with: $0.result)
            }
        }
        
    }
    
}
