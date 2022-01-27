//
//  RequestWorker+Async.swift
//  Spider-Web
//
//  Created by Mitch Treece on 6/15/21.
//

import Foundation

// MARK: Void

@available(iOS 13, *)
@available(macOS 12, *)
public extension RequestWorker /* Void */ {
    
    /// Starts the worker without serializing a response value.
    func void() async throws {
        
        try await withCheckedThrowingContinuation { (c: CheckedContinuation<Void, Error>) in
            voidResponse {
                c.resume(with: $0.result)
            }
        }
                        
    }
    
    /// Starts the worker & serializes a response without a value.
    /// - returns: A serialized `Void` response.
    func voidResponse() async -> Response<Void> {
        
        await withCheckedContinuation { c in
            voidResponse {
                c.resume(returning: $0)
            }
        }
        
    }
    
}

// MARK: Data

@available(iOS 13, *)
@available(macOS 12, *)
public extension RequestWorker /* Data */ {
    
    /// Starts the worker & serializes a `Data` value.
    /// - returns: An optional serialized `Data` value.
    func data() async -> Data? {
        
        await withCheckedContinuation { c in
            dataResponse {
                c.resume(returning: $0.value)
            }
        }
        
    }
    
    /// Starts the worker & serializes a `Data` value.
    /// - returns: A serialized `Data` value.
    func dataThrowing() async throws -> Data {
        
        try await withCheckedThrowingContinuation { c in
            dataResponse {
                c.resume(with: $0.result)
            }
        }
        
    }

    /// Starts the worker & serializes a `Data` response.
    /// - returns: A serialized `Data` response.
    func dataResponse() async -> Response<Data> {
        
        await withCheckedContinuation { c in
            dataResponse {
                c.resume(returning: $0)
            }
        }
        
    }
    
}

// MARK: String

@available(iOS 13, *)
@available(macOS 12, *)
public extension RequestWorker /* String */ {
    
    /// Starts the worker & serializes a `String` value.
    /// - parameter encoding: The string encoding to use; _defaults to utf8_.
    /// - returns: An optional serialized `String` value.
    func string(encoding: String.Encoding = .utf8) async -> String? {
        
        await withCheckedContinuation { c in
            stringResponse(encoding: encoding) {
                c.resume(returning: $0.value)
            }
        }
        
    }
    
    /// Starts the worker & serializes a `String` value.
    /// - parameter encoding: The string encoding to use; _defaults to utf8_.
    /// - returns: A serialized `String` value.
    func stringThrowing(encoding: String.Encoding = .utf8) async throws -> String {
        
        try await withCheckedThrowingContinuation { c in
            stringResponse(encoding: encoding) {
                c.resume(with: $0.result)
            }
        }
        
    }
    
    /// Starts the worker & serializes a `String` response.
    /// - parameter encoding: The string encoding to use; _defaults to utf8_.
    /// - returns: A serialized `String` response.
    func stringResponse(encoding: String.Encoding = .utf8) async -> Response<String> {
        
        await withCheckedContinuation { c in
            stringResponse(encoding: encoding) {
                c.resume(returning: $0)
            }
        }
        
    }
    
}

// MARK: JSON

@available(iOS 13, *)
@available(macOS 12, *)
public extension RequestWorker /* JSON */ {
    
    /// Starts the worker & serializes a `JSON` value.
    /// - returns: An optional serialized `JSON` value.
    func json() async -> JSON? {
    
        await withCheckedContinuation { c in
            jsonResponse {
                c.resume(returning: $0.value)
            }
        }
        
    }
    
    /// Starts the worker & serializes a `JSON` value.
    /// - returns: A serialized `JSON` value.
    func jsonThrowing() async throws -> JSON {
    
        try await withCheckedThrowingContinuation { c in
            jsonResponse {
                c.resume(with: $0.result)
            }
        }
        
    }
    
    /// Starts the worker & serializes a `JSON` response.
    /// - returns: A serialized `JSON` response.
    func jsonResponse() async -> Response<JSON> {
        
        await withCheckedContinuation { c in
            jsonResponse {
                c.resume(returning: $0)
            }
        }
        
    }

    /// Starts the worker & serializes a `JSON` array value.
    /// - returns: An optional serialized `JSON` array value.
    func jsonArray() async -> [JSON]? {
        
        await withCheckedContinuation { c in
            jsonArrayResponse {
                c.resume(returning: $0.value)
            }
        }
        
    }
    
    /// Starts the worker & serializes a `JSON` array value.
    /// - returns: A serialized `JSON` array value.
    func jsonArrayThrowing() async throws -> [JSON] {
        
        try await withCheckedThrowingContinuation { c in
            jsonArrayResponse {
                c.resume(with: $0.result)
            }
        }
        
    }
    
    /// Starts the worker & serializes a `JSON` array response.
    /// - returns: A serialized `JSON` array response.
    func jsonArrayResponse() async -> Response<[JSON]> {
        
        await withCheckedContinuation { c in
            jsonArrayResponse {
                c.resume(returning: $0)
            }
        }
        
    }
    
}

// MARK: Image

@available(iOS 13, *)
@available(macOS 12, *)
public extension RequestWorker /* Image */ {
    
    /// Starts the worker & serializes an `Image` value.
    /// - returns: An optional serialized `Image` value.
    func image() async -> Image? {
        
        await withCheckedContinuation { c in
            imageResponse {
                c.resume(returning: $0.value)
            }
        }
        
    }
    
    /// Starts the worker & serializes an `Image` value.
    /// - returns: A serialized `Image` value.
    func imageThrowing() async throws -> Image {
        
        try await withCheckedThrowingContinuation { c in
            imageResponse {
                c.resume(with: $0.result)
            }
        }
        
    }
    
    /// Starts the worker & serializes a `Image` response.
    /// - returns: A serialized `Image` response.
    func imageResponse() async -> Response<Image> {
        
        await withCheckedContinuation { c in
            imageResponse {
                c.resume(returning: $0)
            }
        }
        
    }
    
}

// MARK: Decode

@available(iOS 13, *)
@available(macOS 12, *)
public extension RequestWorker /* Image */ {
    
    /// Starts the worker & serializes a `Decodable` object value.
    /// - returns: An optional serialized `Decodable` object value.
    func decode<T: Decodable>(_ type: T.Type) async -> T? {
        
        await withCheckedContinuation { c in
            decodeResponse(type) {
                c.resume(returning: $0.value)
            }
        }
        
    }
    
    /// Starts the worker & serializes a `Decodable` object value.
    /// - returns: A serialized `Decodable` object value.
    func decodeThrowing<T: Decodable>(_ type: T.Type) async throws -> T {
        
        try await withCheckedThrowingContinuation { c in
            decodeResponse(type) {
                c.resume(with: $0.result)
            }
        }
        
    }
    
    /// Starts the worker & serializes a `Decodable` object response.
    /// - returns: A serialized `Decodable` object response.
    func decodeResponse<T: Decodable>(_ type: T.Type) async -> Response<T> {
        
        await withCheckedContinuation { c in
            decodeResponse(type) {
                c.resume(returning: $0)
            }
        }
        
    }
    
}
