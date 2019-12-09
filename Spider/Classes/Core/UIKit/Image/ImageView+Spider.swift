//
//  ImageView+Spider.swift
//  Pods
//
//  Created by Mitch Treece on 4/23/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

private enum AssociatedKeys {
    
    static var spider: UInt8 = 0
    static var imageDownloadTask: UInt8 = 0
    
}

public extension ImageView {
    
    /// The image view's `UISpiders` instance.
    var web: UISpider<ImageView> {
        get {
            
            if let web = objc_getAssociatedObject(self, &AssociatedKeys.spider) as? UISpider<ImageView> {
                return web
            }
            
            let web = UISpider<ImageView>()
            self.web = web
            return web
            
        }
        set {
            
            let web = newValue
            web.view = self
            objc_setAssociatedObject(self, &AssociatedKeys.spider, web, .OBJC_ASSOCIATION_RETAIN)
            
        }
    }
    
    internal var imageDownloadTask: SpiderImageDownloadTask? {
        
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.imageDownloadTask) as? SpiderImageDownloadTask
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.imageDownloadTask, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        
    }
    
}

public extension UISpider where T: ImageView {
    
    /// Fetches a remote _or_ cached image for a given URL, then assigns it to the current image view.
    /// - Parameter url: The image's URL.
    /// - Parameter placeholder: A placeholder image to assign to the current image view while the image is being fetched; _defaults to nil_.
    /// - Parameter cacheImage: Flag indicating if the fetched image should be cached; _defaults to true_.
    /// - Parameter completion: The image download completion handler; _defaults to nil_.
    ///
    /// If a `completion` handler is set, the caller is responsible for assigning the image to the image view.
    func setImage(_ url: URLRepresentable,
                  placeholder: Image? = nil,
                  cacheImage: Bool = true,
                  completion: SpiderImageDownloaderCompletion? = nil) {
                
        guard let imageView = self.view as? ImageView else { return }
        
        if let placeholder = placeholder {
            imageView.image = placeholder
        }
        
        imageView.imageDownloadTask = SpiderImageDownloader.getImage(url, cache: cacheImage) { (image, fromCache, error) in
            
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
    
    /// Cancels the current image download task.
    func cancelImageDownload() {
        
        guard let imageView = self.view as? ImageView else { return }
        guard let task = imageView.imageDownloadTask else { return }
        task.cancel()
        
    }
    
}
