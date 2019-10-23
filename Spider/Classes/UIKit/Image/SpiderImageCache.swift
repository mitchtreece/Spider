//
//  SpiderImageCache.swift
//  Pods
//
//  Created by Mitch Treece on 5/26/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation
import Kingfisher

/// `SpiderImageCache` helps cache images to memory & disk.
public class SpiderImageCache {
    
    /// Representation of cache types.
    public enum CacheType {
        case disk
        case memory
    }
    
    /// The shared `SpiderImageCache` instance.
    public static let shared = SpiderImageCache()
    
    private let cache = ImageCache.default
    
    private init() {
        //
    }

    /// Caches an image for a given key.
    /// - Parameter image: The image to cache
    /// - Parameter key: The key to cache the image with
    /// - Parameter completion: The image cache completion handler
    public func cache(_ image: Image, forKey key: String, completion: (()->())?) {

        self.cache.store(
            image,
            forKey: key,
            completionHandler: { _ in
                completion?()
            })
        
    }
    
    /// Fetches a cached image for a given key.
    /// - Parameter key: The cached image's key
    /// - Parameter completion: The retrieval completion handler
    public func image(forKey key: String, completion: @escaping (Image?, Error?)->()) {
                
        self.cache.retrieveImage(forKey: key) { result in
            
            switch result {
            case .success(let value): completion(value.image, nil)
            case .failure(let error): completion(nil, error)
            }
            
        }
                
    }
    
    /// Removes a cached image for a given key.
    /// - Parameter key: The cached image's key
    /// - Parameter completion: The image removal completion handler
    public func removeImage(forKey key: String, completion: (()->())?) {
                
        self.cache.removeImage(
            forKey: key,
            completionHandler: completion
        )
        
    }
    
    /// Cleans the cache for a given type.
    /// - Parameter type: The cache type
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
