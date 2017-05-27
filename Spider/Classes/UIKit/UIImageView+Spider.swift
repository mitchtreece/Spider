//
//  UIImageView+Spider.swift
//  Pods
//
//  Created by Mitch Treece on 4/23/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import UIKit

private var SpiderAssociationKey: UInt8 = 0
private var SpiderImageDownloadTokenAssociationKey: UInt8 = 0

public extension UIImageView {
    
    /**
     The view's `UISpider` instance.
     */
    public var web: UISpider<UIImageView> {
        
        get {
            
            if let web = objc_getAssociatedObject(self, &SpiderAssociationKey) as? UISpider<UIImageView> {
                return web
            }
            
            let web = UISpider<UIImageView>()
            self.web = web
            return web
            
        }
        set {
            
            let web = newValue
            web.view = self
            objc_setAssociatedObject(self, &SpiderAssociationKey, web, .OBJC_ASSOCIATION_RETAIN)
            
        }
        
    }
    
    internal var spdr_imageDownloadToken: SpiderImageDownloadToken? {
        
        get {
            return objc_getAssociatedObject(self, &SpiderImageDownloadTokenAssociationKey) as? SpiderImageDownloadToken
        }
        set {
            objc_setAssociatedObject(self, &SpiderImageDownloadTokenAssociationKey, spdr_imageDownloadToken, .OBJC_ASSOCIATION_RETAIN)
        }
        
    }
    
}

public extension UISpider where T: UIImageView {
    
    /**
     Fetches an online _or_ cached image at a URL, then assigns it to the current `UIImageView`.
     - Parameter url: The image's URL
     - Parameter placeholder: An optional placeholder image to assign to the current `UIImageView` while the image is being fetched
     - Parameter cacheImage: A boolean indicating wether or not the fetched image should be cached.
     
        Defaults to `true`.
     - Parameter completion: The image download completion handler.
     
        If this is set, the caller is responsible for assigning the image to the `UIImageView`.
     */
    public func setImage(_ url: URLConvertible,
                         placeholder: UIImage? = nil,
                         cacheImage: Bool = true,
                         completion: SpiderImageDownloaderCompletion? = nil) {
        
        guard let imageView = view as? UIImageView else { return }
        
        if let placeholder = placeholder {
            imageView.image = placeholder
        }
        
        let token = SpiderImageDownloader.getImage(url, cache: cacheImage) { (image, fromCache, error) in
            
            if let _completion = completion {
                _completion(image, fromCache, error)
            }
            else {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
            
        }
        
        imageView.spdr_imageDownloadToken = token
        
    }
    
    /**
     Cancels the current image download request.
     */
    public func cancelCurrentImageLoad() {
        
        guard let imageView = self.view as? UIImageView else { return }
        guard let token = imageView.spdr_imageDownloadToken else { return }
        SpiderImageDownloader.cancel(for: token)
        
    }
    
}
