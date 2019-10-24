//
//  Data+Size.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/24/19.
//

import Foundation

public extension Data /* Size */ {
    
    struct Size: CustomStringConvertible, CustomDebugStringConvertible {
                
        private var formatter: ByteCountFormatter {
            
            let formatter = ByteCountFormatter()
            formatter.allowedUnits = [.useAll]
            formatter.countStyle = .file
            return formatter
            
        }
        
        public let byteCount: Int64

        public var string: String {
            return self.formatter.string(fromByteCount: self.byteCount)
        }
        
        public var description: String {
            return self.string
        }
        
        public var debugDescription: String {
            return self.description
        }
        
        internal init(byteCount: Int64) {
            self.byteCount = byteCount
        }
        
    }
    
    var size: Size {
        return Size(byteCount: Int64(self.count))
    }
    
}
