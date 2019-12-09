//
//  Body.swift
//  Spider-Web
//
//  Created by Mitch Treece on 11/2/19.
//

import Foundation

/// A data-backed body.
public struct Body {
    
    /// The underlying body data.
    public private(set) var data: Data?
    
    /// The body's size.
    public var size: Data.Size {
        return self.data?.size ?? Data.Size(byteCount: 0)
    }
    
    internal init(data: Data?) {
        self.data = data
    }
    
}
