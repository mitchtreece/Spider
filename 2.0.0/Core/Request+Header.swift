//
//  Request+Header.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/22/18.
//

import Foundation

public extension Request {
    
    public struct Header {
        
        /**
         The type of content provided by the request.
         */
        public var contentType: Request.Body.Format?
        
        /**
         Array of acceptable content types supported by this request.
         If none are provided, the request will accept _all_ content types.
         */
        public var acceptTypes: [Request.Body.Format]?
        
        internal var otherFields = [String: String]()
        
        /**
         Sets the value of a given HTTP header field.
         - Parameter value: The value to set
         - Parameter field: The HTTP header field
         */
        public mutating func set(value: String, forField field: String) {
            otherFields[field] = value
        }
        
        internal init() {
            //
        }
        
    }
    
}
