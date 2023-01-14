//
//  SpiderImageCache+Async.swift
//  Spider-Web
//
//  Created by Mitch Treece on 1/26/22.
//

import UIKit

@available(iOS 13, *)
public extension SpiderImageCache {
    
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
    
    /// Removes a cached image for a given key.
    /// - parameter key: The cached image's key.
    func removeImage(forKey key: String) async {
        
        await withCheckedContinuation { c in
            removeImage(forKey: key) {
                c.resume()
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
    
}
