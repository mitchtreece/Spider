//
//  Body.swift
//  Spider-Web
//
//  Created by Mitch Treece on 11/2/19.
//

import Foundation

public struct Body {
    
    public private(set) var data: Data?
    
    public var size: Data.Size {
        return self.data?.size ?? Data.Size(byteCount: 0)
    }
    
    internal init(data: Data?) {
        self.data = data
    }
    
}
