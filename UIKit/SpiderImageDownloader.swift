//
//  SpiderImageDownloader.swift
//  Pods
//
//  Created by Mitch Treece on 4/23/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation
import SDWebImage

public typealias SpiderImageDownloaderCompletion = (UIImage?, Bool, SpiderError?)->()
public typealias SpiderImageDownloadToken = SDWebImageDownloadToken

/**
 `SpiderImageDownloader` is a image download helper class.
 */
public class SpiderImageDownloader {
    
    /**
     Fetches an image at a given URL.
     - Parameter cache: A boolean indicating wether or not the image should be cached
     - Parameter completion: The image download completion handler
     - Returns: A token that can be used to cancel the download if needed
     */
    @discardableResult
    public static func getImage(_ url: URLConvertible,
                                cache: Bool = false,
                                completion: @escaping SpiderImageDownloaderCompletion) -> SpiderImageDownloadToken? {
        
        guard let url = url.url else {
            completion(nil, false, SpiderError.badUrl)
            return nil
        }
        
        if let image = SpiderImageCache.shared.image(forKey: url.urlString) {
            completion(image, true, nil)
            return nil
        }
        
        let token = SDWebImageDownloader.shared().downloadImage(with: url, options: [], progress: nil) { (image, data, error, finished) in
            
            guard let image = image else {
                completion(nil, false, SpiderError.other(description: "Invalid image data"))
                return
            }
            
            if cache {
                SpiderImageCache.shared.cache(image, forKey: url.urlString, completion: {
                    completion(image, false, nil)
                })
            }
            else {
                completion(image, false, nil)
            }
            
        }
        
        return token
        
    }
    
    /**
     Cancels an image download with a given token.
     - Parameter token: The download token
     */
    public static func cancel(for token: SpiderImageDownloadToken) {
        
        SDWebImageDownloader.shared().cancel(token)
        
    }
    
}
