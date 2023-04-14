//
//  ImageView+Spider.swift
//  Pods
//
//  Created by Mitch Treece on 4/23/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import UIKit
import EspressoLibSupport_Spider

private enum AssociatedKeys {
    
    static var spider: UInt8 = 0
    static var imageDownloadTask: UInt8 = 0
    
}

public extension UIImageView {
    
    /// The image view's `UISpider` instance.
    var web: UISpider<UIImageView> {
        get {
            
            if let web = associatedObject(forKey: AssociatedKeys.spider) as? UISpider<UIImageView> {
                return web
            }
            
            let web = UISpider<UIImageView>()
            self.web = web
            return web
            
        }
        set {
            
            let web = newValue
            web.view = self
            
            setAssociatedObject(
                web,
                forKey: AssociatedKeys.spider
            )
                        
        }
    }
    
    internal var imageDownloadTask: SpiderImageDownloadTask? {
        
        get {
            return associatedObject(forKey: AssociatedKeys.imageDownloadTask) as? SpiderImageDownloadTask
        }
        set {
            setAssociatedObject(newValue, forKey: AssociatedKeys.imageDownloadTask)
        }
        
    }
    
}

public extension UISpider where T: UIImageView {
    
    /// Fetches a remote _or_ cached image for a given url,
    /// then assigns it to the current image view.
    /// - parameter url: The image's url.
    /// - parameter placeholder: A placeholder image to assign to the
    /// current image view while the image is being fetched.
    /// - parameter cacheImage: Flag indicating if the fetched image should be cached.
    /// - parameter completion: The image download completion handler.
    ///
    /// If a `completion` handler is set, the caller is responsible
    /// for assigning the image to the image view.
    func setImage(_ url: URLRepresentable,
                  placeholder: UIImage? = nil,
                  cacheImage: Bool = true,
                  completion: SpiderImageDownloaderCompletion? = nil) {
                
        guard let imageView = self.view as? UIImageView else { return }
        
        if let placeholder = placeholder {
            imageView.image = placeholder
        }
        
        imageView.imageDownloadTask = SpiderImageDownloader
            .getImage(url, cache: cacheImage) { (image, fromCache, error) in
                
                if let _completion = completion {
                    _completion(image, fromCache, error)
                }
                else {
                    
                    DispatchQueue.main.async {
                        imageView.image = image
                    }
                    
                }
                
            }
                
    }
    
    /// Fetches a remote _or_ cached image for a given url,
    /// then assigns it to the current image view.
    /// - parameter url: The image's url.
    /// - parameter placeholder: A placeholder image to assign to the
    /// current image view while the image is being fetched.
    /// - parameter cacheImage: Flag indicating if the fetched image should be cached.
    /// - returns: An optional image result.
    ///
    /// The caller is responsible for assigning the image to the image view.
    func setImage(_ url: URLRepresentable,
                  placeholder: UIImage? = nil,
                  cacheImage: Bool = true) async -> (UIImage?, Bool) {
        
        await withCheckedContinuation { c in
            setImage(url, placeholder: placeholder, cacheImage: cacheImage) { image, fromCache, error in
                c.resume(returning: (image, fromCache))
            }
        }
        
    }
    
    /// Fetches a remote _or_ cached image for a given url,
    /// then assigns it to the current image view.
    /// - parameter url: The image's url.
    /// - parameter placeholder: A placeholder image to assign to the
    /// current image view while the image is being fetched.
    /// - parameter cacheImage: Flag indicating if the fetched image should be cached.
    /// - returns: An image result.
    ///
    /// The caller is responsible for assigning the image to the image view.
    func setImageThrowing(_ url: URLRepresentable,
                          placeholder: UIImage? = nil,
                          cacheImage: Bool = true) async throws -> (UIImage, Bool) {
        
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
    
    /// Cancels the current image download task.
    func cancelImageDownload() {
        
        guard let imageView = self.view as? UIImageView,
              let task = imageView.imageDownloadTask else { return }
        
        task.cancel()
        
    }
    
}
