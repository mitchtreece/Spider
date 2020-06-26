//
//  Headers.swift
//  Spider-Web
//
//  Created by Mitch Treece on 11/2/19.
//

import Foundation

/// A configurable HTTP request header.
public struct Headers {
    
    /// Representation of the various header content types.
    public enum ContentType: Equatable {
        
        public enum Application: String {
            
            /// An application/json content type.
            case json
            
            /// An application/javascript content type.
            case javascript
            
        }
        
        public enum Text: String {
            
            /// A text/plain content type.
            case plain
            
            /// An text/html content type.
            case html
            
            /// A text/json content type.
            case json
            
            /// A text/javascript content type.
            case javascript
            
        }
        
        public enum Image: String {
            
            /// An image/png content type.
            case png
            
            /// An image/jpeg content type.
            case jpeg
            
        }
        
        /// An application content type.
        case application(Application)
        
        /// A text content type.
        case text(Text)
        
        /// An image content type.
        case image(Image)
        
        /// A custom content type.
        case custom(String)
        
        /// The content type's raw value.
        public var value: String {
            
            switch self {
            case .application(let type): return "application/\(type.rawValue)"
            case .text(let type): return "text/\(type.rawValue)"
            case .image(let type): return "image/\(type.rawValue)"
            case .custom(let value): return value
            }
            
        }
        
    }
    
    /// The HTTP content type.
    public var contentType: ContentType?
    
    /// Array of acceptable content types supported by a request.
    ///
    /// If none are provided, the request will accept _all_ content types.
    public var acceptTypes: [ContentType]?
            
    internal private(set) var customFields = [String: String]()
    
    /// Initializes HTTP request headers.
    /// - Parameter content: An optional header content type.
    /// - Parameter accept: Optional header accept types.
    /// - Parameter fields: An optional custom header fields object.
    public init(content: ContentType?,
                accept: [ContentType]?,
                fields: [String: String]?) {
        
        self.contentType = content
        self.acceptTypes = accept
        
        for (key, value) in fields ?? [:] {
            set(value: value, forField: key)
        }
        
    }
    
    public init() {
        //
    }
    
    /// Sets the value of a given HTTP header field.
    /// - Parameter value: The HTTP header value
    /// - Parameter field: The HTTP header field
    public mutating func set(value: String, forField field: String) {
        self.customFields[field] = value
    }
    
    /// Creates a new set of headers by merging another set into the receiver.
    /// - parameter headers: The set of headers to merge in.
    /// - returns: A new set of headers.
    public func merged(with headers: Headers) -> Headers {
        
        let contentType = headers.contentType ?? self.contentType
        let acceptTypes = headers.acceptTypes ?? self.acceptTypes
        
        var fields = self.customFields
        for (key, value) in headers.customFields {
            fields[key] = value
        }
        
        return Headers(
            content: contentType,
            accept: acceptTypes,
            fields: fields
        )
        
    }
    
    // MARK: Private
    
    internal mutating func jsonifyAndPrepare(for request: Request, using spider: Spider) -> [String: String] {
        
        var dictionary = [String: String]()
        
        // Auth

        if let auth = request.authorization {
            dictionary[auth.field] = auth.headerValue
        }
        else if let sharedAuth = spider.authorization {
            dictionary[sharedAuth.field] = sharedAuth.headerValue
        }
        
        // Content type
        
        if let multipartRequest = request as? MultipartRequest {
            
            let content = "multipart/form-data; boundary=\(multipartRequest.boundary)"
            
            // Kinda weird to also mutate our object & update
            // the content-type here.
            
            self.contentType = .custom(content)
            dictionary["Content-Type"] = content
            
        }
        else if let content = self.contentType?.value {
            dictionary["Content-Type"] = content
        }

        // Accept types

        if let acceptTypes = self.acceptTypes {

            var string: String?

            acceptTypes.forEach { type in
                string = (string == nil) ? type.value : "\(string!), \(type.value)"
            }

            dictionary["Accept"] = string

        }
        
        // Custom fields

        for (key, value) in self.customFields {
            dictionary[key] = value
        }
        
        // Done

        return dictionary
        
    }
    
}
