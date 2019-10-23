//
//  SpiderImageDownloadTask.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/22/19.
//

import Foundation
import Kingfisher

/// A cancellable image download task class.
public class SpiderImageDownloadTask: Cancellable {
    
    internal var downloadTask: DownloadTask? {
        didSet {
            
            if self.isCancelled {
                downloadTask?.cancel()
            }
            
        }
    }
    
    public private(set) var isCancelled: Bool = false
    
    public func cancel() {
        
        self.isCancelled = true
        self.downloadTask?.cancel()
        
    }
    
}
