//
//  UISpider.swift
//  Pods
//
//  Created by Mitch Treece on 4/23/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import UIKit

/// Proxy class between `Spider` and a `UIView`.
public class UISpider<T> {
    
    /// Representation of the various UI errors.
    public enum ErrorType: Error {
        
        /// An invalid image error.
        case invalidImage
        
    }
    
    internal weak var view: UIView!
    
}
