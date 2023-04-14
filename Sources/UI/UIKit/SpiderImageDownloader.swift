//
//  SpiderImageDownloader.swift
//  Pods
//
//  Created by Mitch Treece on 4/23/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import UIKit
import EspressoLibSupport_Spider
import Kingfisher
import Spider

/// Image download completion handler.
/// - Parameter image: The retrieved or downloaded image.
/// - Parameter fromCache: Flag indicating if the image was retrieved from the cache.
/// - Parameter error: The error associated with the download task.
public typealias SpiderImageDownloaderCompletion = (
    _ image: UIImage?,
    _ fromCache: Bool,
    _ error: Error?
)->()

/// Image download helper class.
public class SpiderImageDownloader {
    
    /// Representation of the various image downloading errors.
    public enum ErrorType: Error {
        
        /// An invalid image download error.
        case invalidImage
        
    }
    
    /// Fetches an image at a given URL.
    /// - Parameter url: The image URL.
    /// - Parameter cache: A boolean indicating if the image should be cached; _defaults to false_.
    /// - Parameter completion: The image download completion handler.
    /// - Returns: An image download task.
    @discardableResult
    public static func getImage(_ url: URLRepresentable,
                                cache: Bool = false,
                                completion: @escaping SpiderImageDownloaderCompletion) -> SpiderImageDownloadTask? {
        
        guard let url = url.asUrl() else {
            completion(nil, false, Request.Error.badUrl)
            return nil
        }
        
        let urlString = url.absoluteString
        let task = SpiderImageDownloadTask()
        
        SpiderImageCache.shared.image(forKey: urlString) { (image, error) in
            
            if let image = image {
                completion(image, true, nil)
                return
            }
            
            task.downloadTask = ImageDownloader.default.downloadImage(with: url) { result in
                
                switch result {
                case .success(let value):
                    
                    let image = value.image as UIImage
                    
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
