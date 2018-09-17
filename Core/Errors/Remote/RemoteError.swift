//
//  RemoteError.swift
//  Spider-Web
//
//  Created by Mitch Treece on 8/23/18.
//

import Foundation

//public struct ResponseRemoteError: SpiderErrorProtocol {
//    
//    public var description: String
//    public var response: Response?
//    
//    public init(description: String, response: Response) {
//        
//        self.description = description
//        self.response = response
//        
//    }
//    
//    public init(error: SpiderError) {
//        
//        self.description = error.localizedDescription
//        
//        switch error {
//        case .badResponse(let res): self.response = res
//        default: break
//        }
//        
//    }
//    
//    public var errorDescription: String? {
//        
//        if let res = response {
//            return "[\(res.statusCode.rawValue)] <\(res.request.path)>: \(description)"
//        }
//        
//        return description
//        
//    }
//    
//}
