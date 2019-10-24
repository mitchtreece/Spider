//
//  JSONResponseErrorCatcher.swift
//  Spider-Web
//
//  Created by Mitch Treece on 10/20/19.
//

import Foundation

//{
//    "error": {
//        "name": "ServerError",
//        "description": "something went wrong"
//    }
//}

//public struct JSONResponseErrorCatcher: ResponseErrorCatcher {    
//    
////    public func `catch`(response: Response<JSON>) -> ResponseError<JSON>? {
////
////        guard let json = response.value else {
////
////            return ResponseError<JSON>(
////                response: response,
////                error: .badResponseData
////            )
////
////        }
////
////        guard let errorDict = json["error"] as? JSON,
////            let name = errorDict["name"] as? String else { return nil }
////
////        var description = "\(name)"
////
////        if let _description = errorDict["description"] as? String {
////            description += ": \(_description)"
////        }
////
////        return ResponseError<JSON>(
////            response: response,
////            description: description // i.e. [500] </path/to/endpoint> - ServerError: something went wrong
////        )
////
////    }
//    
//}
