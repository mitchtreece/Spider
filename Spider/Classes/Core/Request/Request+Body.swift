//
//  Request+Body.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/22/18.
//

import Foundation

public extension Request {
        
    struct Body {
        
        public private(set) var data: Data?
        
        public var size: Data.Size {
            return self.data?.size ?? Data.Size(byteCount: 0)
        }
        
        internal init(data: Data?) {
            self.data = data
        }
        
    }
    
}
