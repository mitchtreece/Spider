//
//  UISpider+Async.swift
//  Spider-Web
//
//  Created by Mitch Treece on 1/26/22.
//

import Foundation

@available(iOS 13, *)
@available(macOS 12, *)
public extension UISpider where T: ImageView {
    
    /// Fetches a remote _or_ cached image for a given URL, then assigns it to the current image view.
    /// - parameter url: The image's URL.
    /// - parameter placeholder: A placeholder image to assign to the current image view while the image is being fetched; _defaults to nil_.
    /// - parameter cacheImage: Flag indicating if the fetched image should be cached; _defaults to true_.
    /// - returns: An optional image result.
    ///
    /// The caller is responsible for assigning the image to the image view.
    func setImage(_ url: URLRepresentable,
                  placeholder: Image? = nil,
                  cacheImage: Bool = true) async -> (Image?, Bool) {
        
        await withCheckedContinuation { c in
            setImage(url, placeholder: placeholder, cacheImage: cacheImage) { image, fromCache, error in
                c.resume(returning: (image, fromCache))
            }
        }
        
    }
    
    /// Fetches a remote _or_ cached image for a given URL, then assigns it to the current image view.
    /// - parameter url: The image's URL.
    /// - parameter placeholder: A placeholder image to assign to the current image view while the image is being fetched; _defaults to nil_.
    /// - parameter cacheImage: Flag indicating if the fetched image should be cached; _defaults to true_.
    /// - returns: An image result.
    ///
    /// The caller is responsible for assigning the image to the image view.
    func setImageThrowing(_ url: URLRepresentable,
                          placeholder: Image? = nil,
                          cacheImage: Bool = true) async throws -> (Image, Bool) {
        
        try await withCheckedThrowingContinuation { c in
            
            setImage(url, placeholder: placeholder, cacheImage: cacheImage) { image, fromCache, error in
                
                if let error = error {
                    c.resume(throwing: error)
                    return
                }
                else if let image = image {
                    c.resume(returning: (image, fromCache))
                    return
                }
                
                c.resume(throwing: ErrorType.invalidImage)
                
            }
            
        }
        
    }
    
}
