//
//  SpiderImageDownloader.swift
//  Pods
//
//  Created by Mitch Treece on 4/23/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation
import Kingfisher

/// Image download completion handler.
/// - Parameter image: The retrieved or downloaded image.
/// - Parameter fromCache: Flag indicating if the image was retrieved from the cache.
/// - Parameter error: The error associated with the download task.
public typealias SpiderImageDownloaderCompletion = (_ image: Image?, _ fromCache: Bool, _ error: Error?)->()

/// Image download helper class.
public class SpiderImageDownloader {
    
    /// Fetches an image at a given URL.
    /// - Parameter url: The image URL.
    /// - Parameter cache: A boolean indicating if the image should be cached; _defaults to false_.
    /// - Parameter completion: The image download completion handler.
    /// - Returns: An image download task.
    @discardableResult
    public static func getImage(_ url: URLRepresentable,
                                cache: Bool = false,
                                completion: @escaping SpiderImageDownloaderCompletion) -> SpiderImageDownloadTask? {
        
        guard let url = url.url,
            let urlString = url.urlString else {
            completion(nil, false, Request.Error.badUrl)
            return nil
        }
        
        let task = SpiderImageDownloadTask()
        
        SpiderImageCache.shared.image(forKey: urlString) { (image, error) in
            
            if let image = image {
                completion(image, true, nil)
                return
            }
            
            task.downloadTask = ImageDownloader.default.downloadImage(with: url) { result in
                
                switch result {
                case .success(let value):
                    
                    let image = value.image as Image
                    
                    if cache {
                        
                        SpiderImageCache.shared.cache(image, forKey: urlString) {
                            completion(image, false, nil)
                        }
                        
                    }
                    else {
                        completion(image, false, nil)
                    }
                    
                case .failure(let error): completion(nil, false, error)
                }
                
            }
            
        }
        
        return task
        
    }
    
}
