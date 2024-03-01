//
//  RequestWorker+Image.swift
//  Spider-Web
//
//  Created by Mitch Treece on 1/13/23.
//

import Spider
import Kingfisher

public extension RequestWorker /* Image */ {
    
    /// Starts the worker & serializes an image value.
    /// - parameter completion: The worker's completion closure.
    func image(_ completion: @escaping (KFCrossPlatformImage?, Error?)->()) {
        
        imageResponse {
            completion(
                $0.value,
                $0.error
            )
        }
        
    }
    
    /// Starts the worker & serializes an image value.
    /// - returns: An optional serialized image value.
    func image() async -> KFCrossPlatformImage? {

        await withCheckedContinuation { c in
            imageResponse {
                c.resume(returning: $0.value)
            }
        }

    }
    
    /// Starts the worker & serializes an image value.
    /// - returns: A serialized image value.
    func imageThrowing() async throws -> KFCrossPlatformImage {

        try await withCheckedThrowingContinuation { c in
            imageResponse {
                c.resume(with: $0.result)
            }
        }

    }
    
    /// Starts the worker & serializes an image response.
    /// - parameter completion: The worker's completion closure.
    func imageResponse(_ completion: @escaping (Response<KFCrossPlatformImage>)->()) {
        
        dataResponse { response in
            completion(response.compactMap {
                KFCrossPlatformImage(data: $0)
            })
        }
        
    }
    
    /// Starts the worker & serializes an image response.
    /// - returns: A serialized image response.
    func imageResponse() async -> Response<KFCrossPlatformImage> {

        await withCheckedContinuation { c in
            imageResponse {
                c.resume(returning: $0)
            }
        }

    }
    
    /// Adds an image-response passthrough to the worker.
    /// - parameter block: The passthrough closure.
    /// - returns: This `RequestWorker`.
    func imageResponsePassthrough(_ block: @escaping (Response<KFCrossPlatformImage>)->()) -> Self {
        
        return dataResponsePassthrough { res in
            block(res.compactMap{
                KFCrossPlatformImage(data: $0)
            })
        }
        
    }
    
    /// Adds an image passthrough to the worker.
    /// - parameter block: The passthrough closure.
    /// - returns: This `RequestWorker`.
    func imagePassthrough(_ block: @escaping (KFCrossPlatformImage?)->()) -> Self {
        
        return imageResponsePassthrough { res in
            block(res.value)
        }
        
    }
    
}
