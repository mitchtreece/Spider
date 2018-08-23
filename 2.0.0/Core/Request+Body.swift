//
//  Request+Body.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/22/18.
//

import Foundation

public extension Request {
    
    public struct Body {
        
        public enum Format {
            
            case application_json
            case application_javascript
            case text_json
            case text_javascript
            case text_html
            case text_plain
            case image_jpeg
            case multipart
            case other(String)
            
            func value(for request: Request) -> String {
                
                switch self {
                case .application_json: return "application/json"
                case .application_javascript: return "application/javascript"
                case .text_json: return "text/json"
                case .text_javascript: return "text/javascript"
                case .text_html: return "text/html"
                case .text_plain: return "text/plain"
                case .image_jpeg: return "image/jpeg"
                case .multipart: return "" // TODO: This
                case .other(let type): return type
                }
                
            }
            
        }
        
        public var data: Data?
        
        internal init() {
            //
        }
        
    }
    
}
