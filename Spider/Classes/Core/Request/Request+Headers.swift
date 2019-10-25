//
//  Request+Headers.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/22/18.
//

import Foundation

public extension Request {
    
    struct Headers {
        
        public enum ContentType {
            
            case application_json
            case application_javascript
            case text_json
            case text_javascript
            case text_html
            case text_plain
            case image_jpeg
            case multipart
            case custom(String)
            
            func value(for request: Request) -> String {
                
                switch self {
                case .application_json: return "application/json"
                case .application_javascript: return "application/javascript"
                case .text_json: return "text/json"
                case .text_javascript: return "text/javascript"
                case .text_html: return "text/html"
                case .text_plain: return "text/plain"
                case .image_jpeg: return "image/jpeg"
                case .multipart:
                    
                    let boundary = (request as? MultipartRequest)?.boundary ?? UUID().uuidString
                    return "multipart/form-data; boundary=\(boundary)"
                    
                case .custom(let type): return type
                }
                
            }
            
        }
        
        /**
         The type of content provided by the request.
         */
        public var contentType: ContentType?
        
        /**
         Array of acceptable content types supported by this request.
         If none are provided, the request will accept _all_ content types.
         */
        public var acceptTypes: [ContentType]?
                
        internal var otherFields = [String: String]()
        
        internal func dictionaryRepresentation(for request: Request, using spider: Spider) -> [String: String] {

            var dictionary = [String: String]()
            
            // Auth
            
            if let auth = request.authorization {
                dictionary[auth.field] = auth.headerValue
            }
            else if let sharedAuth = spider.authorization {
                dictionary[sharedAuth.field] = sharedAuth.headerValue
            }
            
            // Content type
            
            if let contentType = self.contentType?.value(for: request) {
                dictionary["Content-Type"] = contentType
            }
            
            // Accept types
            
            if let acceptTypes = self.acceptTypes {
                
                var string: String?
                
                acceptTypes.forEach { type in
                    let value = type.value(for: request)
                    string = (string == nil) ? value : "\(string!), \(value)"
                }
                
                dictionary["Accept"] = string
                
            }
            
            // Other fields
            
            for (key, value) in self.otherFields {
                dictionary[key] = value
            }
            
            return dictionary
            
        }
        
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
