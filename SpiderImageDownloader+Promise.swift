//
//  SpiderImageDownloader+Promise.swift
//  Spider-Web
//
//  Created by Mitch Treece on 6/16/21.
//

import Foundation
import PromiseKit

public extension SpiderImageDownloader {
    
    /// Fetches an image at a given URL.
    /// - Parameter url: The image URL.
    /// - Parameter cache: A boolean indicating if the image should be cached; _defaults to false_.
    /// - Parameter completion: The image download completion handler.
    /// - Returns: An image download task.
    @discardableResult
    static func getImage(_ url: URLRepresentable,
                         cache: Bool = false) -> Promise<((Image, Bool), SpiderImageDownloadTask?)> {
        
        return Promise<((Image, Bool), SpiderImageDownloadTask?)> { seal in
            
            let task = self.getImage(url, cache: cache) { image, fromCache, error in
                
            }
            
        }
        
    }
    
}
