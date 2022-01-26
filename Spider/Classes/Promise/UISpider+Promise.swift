//
//  UISpider+Promise.swift
//  Spider-Web
//
//  Created by Mitch Treece on 6/16/21.
//

import Foundation
import PromiseKit

public extension UISpider where T: ImageView {
    
    /// Fetches a remote _or_ cached image for a given URL, then assigns it to the current image view.
    /// - parameter url: The image's URL.
    /// - parameter placeholder: A placeholder image to assign to the current image view while the image is being fetched; _defaults to nil_.
    /// - parameter cacheImage: Flag indicating if the fetched image should be cached; _defaults to true_.
    /// - returns: An `Image`, `Bool` tuple promise.
    ///
    /// The caller is responsible for assigning the image to the image view.
    func setImage(_ url: URLRepresentable,
                  placeholder: Image? = nil,
                  cacheImage: Bool = true) -> Promise<(Image, Bool)> {
        
        return Promise<(Image, Bool)> { seal in
            
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
