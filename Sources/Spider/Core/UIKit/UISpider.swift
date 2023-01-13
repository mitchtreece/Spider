//
//  UISpider.swift
//  Pods
//
//  Created by Mitch Treece on 4/23/17.
//  Copyright (c) 2017 Mitch Treece. All rights reserved.
//

import Foundation

/// Proxy class between `Spider` & the current platform's UI layer.
public class UISpider<T> {
    
    /// Representation of the various UI errors.
    public enum ErrorType: Error {
        
        /// An invalid image error.
        case invalidImage
        
    }
    
    internal weak var view: View!
    
}
