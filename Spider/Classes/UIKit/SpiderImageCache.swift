//
//  SpiderImageCache.swift
//  Pods
//
//  Created by Mitch Treece on 5/26/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation
import SDWebImage

/**
 `SpiderImageCache` helps cache images to memory & disk.
 */
public class SpiderImageCache {
    
    /**
     Representation of cache types.
     */
    public enum CacheType {
        case disk
        case memory
    }
    
    /**
     The shared `SpiderImageCache` instance.
     */
    public static let shared = SpiderImageCache()
    
    private let _cache = SDImageCache.shared
    
    // TODO: Implement cache limits
    // var itemLimit: UInt
    // var memoryLimit: UInt
    // var ageLimit: UInt
    
    private init() {
        //
    }
    
    /**
     Caches a `UIImage` for a given key.
     - Parameter image: The `UIImage` to cache
     - Parameter key: The key to cache the image with
     - Parameter completion: The image cache completion handler
     */
    public func cache(_ image: UIImage?, forKey key: String?, completion: (()->())?) {
        
        guard let image = image, let key = key else { return }
        _cache.store(image, forKey: key, completion: completion)
        
    }
    
    /**
     Fetches a cached `UIImage` for a given key.
     - Parameter key: The cached image's key
     - Returns: The cached `UIImage`.
     */
    public func image(forKey key: String?) -> UIImage? {
        
        guard let key = key else { return nil }
        
        if let image = _cache.imageFromCache(forKey: key) {
            return image
        }
        
        return nil
        
    }
    
    /**
     Removes a cached `UIImage` for a given key.
     - Parameter key: The cached image's key
     - Parameter completion: The image removal completion handler
     */
    public func removeImage(forKey key: String?, completion: (()->())?) {
        
        guard let key = key else { return }
        _cache.removeImage(forKey: key, withCompletion: completion)
        
    }
    
    /**
     Cleans the cache for a given type.
     - Parameter type: The cache type
     */
    public func clean(_ type: CacheType) {
        
        switch type {
        case .disk: _cache.clearDisk(onCompletion: nil)
        case .memory: _cache.clearMemory()
        }
        
    }
    
    /**
     Cleans the memory & disk caches.
     */
    public func cleanAll() {
        
        _cache.clearDisk()
        _cache.clearMemory()
        
    }
    
}
