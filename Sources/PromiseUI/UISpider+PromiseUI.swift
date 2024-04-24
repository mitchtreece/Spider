//
//  UISpider+Promise.swift
//  Spider-Web
//
//  Created by Mitch Treece on 6/16/21.
//

#if canImport(UIKit)

import SpiderUI
import PromiseKit
import protocol Espresso.URLRepresentable

public extension UISpider where T: UIImageView {
    
    /// Fetches a remote _or_ cached image for a given URL, then assigns it to the current image view.
    /// - parameter url: The image's URL.
    /// - parameter placeholder: A placeholder image to assign to the current
    /// image view while the image is being fetched.
    /// - parameter cacheImage: Flag indicating if the fetched image should be cached.
    /// - returns: An `Image`, `Bool` tuple promise.
    ///
    /// The caller is responsible for assigning the image to the image view.
    func setImage(_ url: URLRepresentable,
                  placeholder: UIImage? = nil,
                  cacheImage: Bool = true) -> Promise<(UIImage, Bool)> {
        
        return Promise<(UIImage, Bool)> { seal in
            
            self.setImage(
                
                url,
                placeholder: placeholder,
                cacheImage: cacheImage
                
            ) { image, fromCache, error in
            
                if let error = error {
                    seal.reject(error)
                    return
                }
                
                seal.fulfill((image!, fromCache))
                
            }

        }
                
    }
    
}

#endif
