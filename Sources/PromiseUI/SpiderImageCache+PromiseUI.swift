//
//  SpiderImageCache+Promise.swift
//  Spider-Web
//
//  Created by Mitch Treece on 6/16/21.
//

import SpiderUI
import Kingfisher
import PromiseKit

public extension SpiderImageCache {
    
    /// Caches an image for a given key.
    /// - parameter image: The image to cache.
    /// - parameter key: The key to cache the image with.
    /// - returns: A `Void` promise.
    func cache(_ image: KFCrossPlatformImage,
               forKey key: String) -> Promise<Void> {

        return Promise<Void> { seal in
            
            self.cache(image, forKey: key) {
                seal.fulfill(())
            }
            
        }
        
    }
    
    /// Fetches a cached image for a given key.
    /// - parameter key: The cached image's key.
    /// - returns: An `Image` promise.
    func image(forKey key: String) -> Promise<KFCrossPlatformImage> {
        
        return Promise<KFCrossPlatformImage> { seal in
            
            self.image(forKey: key) { image, error in
             
                if let error = error {
                    seal.reject(error)
                    return
                }
                
                seal.fulfill(image!)
                
            }
            
        }
        
    }
    
    /// Removes a cached image for a given key.
    /// - parameter key: The cached image's key.
    /// - returns: A `Void` promise.
    func removeImage(forKey key: String) -> Promise<Void> {
                
        return Promise<Void> { seal in
            
            self.removeImage(forKey: key) {
                seal.fulfill(())
            }
            
        }
        
    }
    
}
