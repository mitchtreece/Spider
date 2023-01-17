//
//  SpiderImageCache.swift
//  Pods
//
//  Created by Mitch Treece on 5/26/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import UIKit
import Kingfisher

/// Helper class that caches images to memory & disk.
public class SpiderImageCache {
    
    /// Representation of the various cache types.
    public enum CacheType {
        
        /// A disk cache type.
        case disk
        
        /// An in-memory cache type.
        case memory
        
    }
    
    /// Representation of the various image caching errors.
    public enum ErrorType: Error {
        
        /// An invalid image error.
        case invalidImage
        
    }
    
    /// The shared `SpiderImageCache` instance.
    public static let shared = SpiderImageCache()
    
    internal let cache = ImageCache.default
    
    private init() {
        //
    }

    /// Caches an image for a given key.
    /// - Parameter image: The image to cache.
    /// - Parameter key: The key to cache the image with.
    /// - Parameter completion: An optional image cache completion handler.
    public func cache(_ image: UIImage,
                      forKey key: String,
                      completion: (()->())?) {

        self.cache.store(
            image,
            forKey: key,
            completionHandler: { _ in
                completion?()
            })
        
    }
    
    /// Caches an image for a given key.
    /// - parameter image: The image to cache.
    /// - parameter key: The key to cache the image with.
    func cache(_ image: UIImage,
               forKey key: String) async {
        
        await withCheckedContinuation { c in
            cache(image, forKey: key) {
                c.resume()
            }
        }
        
    }
    
    /// Fetches a cached image for a given key.
    /// - Parameter key: The cached image's key.
    /// - Parameter completion: The retrieval completion handler.
    public func image(forKey key: String,
                      completion: @escaping (UIImage?, Error?)->()) {
                
        self.cache.retrieveImage(forKey: key) { result in
            
            switch result {
            case .success(let value): completion(value.image, nil)
            case .failure(let error): completion(nil, error)
            }
            
        }
                
    }
    
    /// Fetches a cached image for a given key.
    /// - parameter key: The cached image's key.
    /// - returns: An optional image.
    func image(forKey key: String) async -> UIImage? {
        
        await withCheckedContinuation { c in
            image(forKey: key) { image, error in
                c.resume(returning: image)
            }
        }
        
    }
    
    /// Fetches a cached image for a given key.
    /// - parameter key: The cached image's key.
    /// - returns: The cached image.
    func imageThrowing(forKey key: String) async throws -> UIImage {
        
        try await withCheckedThrowingContinuation { c in
            image(forKey: key) { image, error in
                
                if let error = error {
                    c.resume(throwing: error)
                    return
                }
                else if let image = image {
                    c.resume(returning: image)
                    return
                }
                
                c.resume(throwing: ErrorType.invalidImage)
                
            }
        }
        
    }
    
    /// Removes a cached image for a given key.
    /// - Parameter key: The cached image's key.
    /// - Parameter completion: An optional image removal completion handler.
    public func removeImage(forKey key: String,
                            completion: (()->())?) {
                
        self.cache.removeImage(
            forKey: key,
            completionHandler: completion
        )
        
    }
    
    /// Removes a cached image for a given key.
    /// - parameter key: The cached image's key.
    func removeImage(forKey key: String) async {
        
        await withCheckedContinuation { c in
            removeImage(forKey: key) {
                c.resume()
            }
        }
        
    }
    
    /// Cleans the cache for a given type.
    /// - Parameter type: The cache type.
    public func clean(_ type: CacheType) {
        
        switch type {
        case .disk: self.cache.clearDiskCache()
        case .memory: self.cache.clearMemoryCache()
        }
        
    }
    
    /// Cleans all caches.
    public func cleanAll() {
        
        self.cache.clearDiskCache()
        self.cache.clearMemoryCache()
        
    }
    
}
