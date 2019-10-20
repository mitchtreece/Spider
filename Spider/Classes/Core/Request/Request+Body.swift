//
//  Request+Body.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/22/18.
//

import Foundation

public extension Request {
    
    struct Body {
        
        public var data: Data?
        
        internal init(data: Data?) {
            self.data = data
        }
        
    }
    
}
