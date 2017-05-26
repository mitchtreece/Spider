//
//  SpiderImageDownloader.swift
//  Pods
//
//  Created by Mitch Treece on 4/23/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation
import SDWebImage

public typealias SpiderImageDownloaderCompletion = (UIImage?, Bool, ErrorConvertible?)->()
public typealias SpiderImageDownloadToken = SDWebImageDownloadToken

public class SpiderImageDownloader {
    
    @discardableResult
    public static func getImage(_ url: URLConvertible,
                                cache: Bool = false,
                                completion: @escaping SpiderImageDownloaderCompletion) -> SpiderImageDownloadToken? {
        
        guard let url = url.url else {
            completion(nil, false, SpiderError.invalidUrl)
            return nil
        }
        
        if let image = SpiderImageCache.shared.image(forKey: url.urlString) {
            completion(image, true, nil)
            return nil
        }
        
        let token = SDWebImageDownloader.shared().downloadImage(with: url, options: [], progress: nil) { (image, data, error, finished) in
            
            guard let image = image else {
                completion(nil, false, SpiderError.invalidImageData)
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
    
    public static func cancel(for token: SpiderImageDownloadToken) {
        
        SDWebImageDownloader.shared().cancel(token)
        
    }
    
}
