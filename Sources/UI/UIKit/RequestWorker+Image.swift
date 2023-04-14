//
//  RequestWorker+Image.swift
//  Spider-Web
//
//  Created by Mitch Treece on 1/13/23.
//

import UIKit
import Spider

public extension RequestWorker /* Image */ {
    
    /// Starts the worker & serializes a `UIImage` value.
    /// - parameter completion: The worker's completion closure.
    func image(_ completion: @escaping (UIImage?, Error?)->()) {
        
        imageResponse {
            completion(
                $0.value,
                $0.error
            )
        }
        
    }
    
    /// Starts the worker & serializes a `UIImage` value.
    /// - returns: An optional serialized `UIImage` value.
    func image() async -> UIImage? {

        await withCheckedContinuation { c in
            imageResponse {
                c.resume(returning: $0.value)
            }
        }

    }
    
    /// Starts the worker & serializes a `UIImage` value.
    /// - returns: A serialized `UIImage` value.
    func imageThrowing() async throws -> UIImage {

        try await withCheckedThrowingContinuation { c in
            imageResponse {
                c.resume(with: $0.result)
            }
        }

    }
    
    /// Starts the worker & serializes a `UIImage` response.
    /// - parameter completion: The worker's completion closure.
    func imageResponse(_ completion: @escaping (Response<UIImage>)->()) {
        
        dataResponse { response in
            completion(response.compactMap {
                UIImage(data: $0)
            })
        }
        
    }
    
    /// Starts the worker & serializes a `UIImage` response.
    /// - returns: A serialized `UIImage` response.
    func imageResponse() async -> Response<UIImage> {

        await withCheckedContinuation { c in
            imageResponse {
                c.resume(returning: $0)
            }
        }

    }
    
    /// Adds an image-response passthrough to the worker.
    /// - parameter block: The passthrough closure.
    /// - returns: This `RequestWorker`.
    func imageResponsePassthrough(_ block: @escaping (Response<UIImage>)->()) -> Self {
        
        return dataResponsePassthrough { res in
            block(res.compactMap{
                UIImage(data: $0)
            })
        }
        
    }
    
    /// Adds an image passthrough to the worker.
    /// - parameter block: The passthrough closure.
    /// - returns: This `RequestWorker`.
    func imagePassthrough(_ block: @escaping (UIImage?)->()) -> Self {
        
        return imageResponsePassthrough { res in
            block(res.value)
        }
        
    }
    
}
