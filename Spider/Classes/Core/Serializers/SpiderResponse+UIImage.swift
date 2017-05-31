//
//  SpiderResponse+UIImage.swift
//  Pods
//
//  Created by Mitch Treece on 5/31/17.
//
//

import UIKit

public extension SpiderResponse {
    
    public func image() -> UIImage? {
        
        return self.data?.image
        
    }
    
}
