//
//  ResponseError.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

//public struct ResponseError<T>: LocalizedError {
//    
//    public let response: Response<T>
//    public let description: String
//    
//    public init(response: Response<T>, description: String) {
//        
//        self.response = response
//        self.description = description
//        
//    }
//    
//    public init(response: Response<T>, error: SpiderError) {
//        
//        self.response = response
//        self.description = error.localizedDescription
//        
//    }
//    
//    public var errorDescription: String? {
//        
//        if let statusCode = self.response.statusCode {
//            return "[\(statusCode.rawValue)] <\(self.response.request.path)> - \(self.description)"
//        }
//        else {
//            return "<\(self.response.request.path)> - \(self.description)"
//        }
//        
//    }
//    
//}
