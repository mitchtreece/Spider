//
//  SpiderImageCache.swift
//  Pods
//
//  Created by Mitch Treece on 5/26/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation
import SDWebImage

public class SpiderImageCache {
    
    public enum CacheType {
        case disk
        case memory
    }
    
    public static let shared = SpiderImageCache()
    private let _cache = SDImageCache.shared()
    
    // var itemLimit: UInt
    // var memoryLimit: UInt
    // var ageLimit: UInt
    
    private init() {
        //
    }
    
    public func cache(_ image: UIImage?, forKey key: String?, completion: (()->())?) {
        
        guard let image = image, let key = key else { return }
        _cache.store(image, forKey: key, completion: completion)
        
    }
    
    public func image(forKey key: String?) -> UIImage? {
        
        guard let key = key else { return nil }
        
        if let image = _cache.imageFromCache(forKey: key) {
            return image
        }
        
        return nil
        
    }
    
    public func clean(_ type: CacheType) {
        
        switch type {
        case .disk: _cache.clearDisk(onCompletion: nil)
        case .memory: _cache.clearMemory()
        }
        
    }
    
    public func cleanAll() {
        
        _cache.clearDisk()
        _cache.clearMemory()
        
    }
    
}
